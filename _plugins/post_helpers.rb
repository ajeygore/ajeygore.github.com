# Editorial post helpers — runs as a Jekyll hook before rendering, attaching
# pre-computed values to each post's data hash. This avoids the Liquid-filter
# load-order quirk where bare custom filters intermittently fail to register
# on GitHub Actions production builds. Hooks always run.
#
# Computed per-post:
#   page.editorial.reading_minutes  Integer
#   page.editorial.word_count       Integer
#   page.editorial.toc              Array of { level, id, title }
#   page.editorial.lede_html        String (first prose paragraph, or nil)
#   page.editorial.epigraph_html    String (extracted from inline <div.post-epigraph>, or nil)
#   page.editorial.content_html     String (rendered content minus lede + epigraph)
#   page.editorial.hero_src         String (resolved hero image URL, or nil)
#   page.editorial.hero_is_og       Boolean

require 'nokogiri'
require 'json'

module PostEditorial
  WORDS_PER_MINUTE = 220
  RASTER_EXTS      = %w[.png .jpg .jpeg .webp .avif .svg].freeze

  module_function

  def compute(rendered_html, page, site)
    text = strip_for_count(rendered_html.to_s)
    words = text.split(/\s+/).reject(&:empty?).length

    doc = Nokogiri::HTML.fragment(rendered_html.to_s)
    epigraph = extract_epigraph(doc)
    lede = extract_lede(doc)
    toc  = extract_toc(doc)
    hero_src, hero_is_og = resolve_hero(page, site)

    {
      'reading_minutes' => [(words.to_f / WORDS_PER_MINUTE).ceil, 1].max,
      'word_count'      => words,
      'toc'             => toc,
      'toc_json'        => toc.to_json,
      'lede_html'       => lede,
      'epigraph_html'   => epigraph,
      'content_html'    => doc.to_html,
      'hero_src'        => hero_src,
      'hero_is_og'      => hero_is_og
    }
  end

  def strip_for_count(html)
    html.gsub(/<[^>]+>/, ' ').gsub(/\s+/, ' ').strip
  end

  # Pulls the body-embedded epigraph (legacy <div class="post-epigraph">),
  # returning its inner text. Removes the node from `doc` as a side effect.
  def extract_epigraph(doc)
    div = doc.at_css('div.post-epigraph, aside.post-epigraph')
    return nil if div.nil?
    inner_p = div.at_css('p')
    out = (inner_p ? inner_p.inner_html : div.inner_html).strip
    div.remove
    out
  end

  # First direct-child <p> that's plain prose and at least 60 chars.
  # Removes the node from `doc` so the layout can render it separately.
  def extract_lede(doc)
    p = doc.children.find { |c| c.element? && c.name == 'p' }
    return nil if p.nil?
    return nil if p.css('img').any? && p.text.strip.length < 20
    return nil if p.text.strip.length < 60
    inner = p.inner_html
    p.remove
    inner
  end

  def extract_toc(doc)
    doc.css('h2, h3').filter_map do |h|
      next nil if h['data-toc-skip']
      id = h['id']
      next nil if id.nil? || id.empty?
      { 'level' => (h.name == 'h2' ? 2 : 3), 'id' => id, 'title' => h.text.strip }
    end
  end

  def resolve_hero(page, site)
    src = nil
    is_og = false

    hero_image = page.data['hero_image']
    if hero_image
      rel = "assets/images/#{hero_image}"
      src = "/#{rel}" if File.file?(File.join(site.source, rel))
    end

    if src.nil?
      lead = page.data['lead_image']
      if lead
        ext = File.extname(lead).downcase
        if RASTER_EXTS.include?(ext)
          rel = "assets/images/#{lead}"
          src = "/#{rel}" if File.file?(File.join(site.source, rel))
        end
      end
    end

    if src.nil?
      slug = (page.data['slug'] || page.basename_without_ext.sub(/\A\d{4}-\d{2}-\d{2}-/, '')).downcase
      rel = "assets/images/blog/og/#{slug}.png"
      if File.file?(File.join(site.source, rel))
        src = "/#{rel}"
        is_og = true
      end
    end

    [src, is_og]
  end
end

# Pre-render hook: convert the post's markdown source to HTML ourselves so
# we can analyze it and attach editorial data BEFORE the layout renders.
# (At :pre_render time, post.content is still raw markdown — we need the
# converted HTML to find the lede paragraph, ToC anchors, etc.)
Jekyll::Hooks.register :posts, :pre_render do |post|
  ext = File.extname(post.relative_path)
  converter = post.site.find_converter_instance(Jekyll::Converters::Markdown)
  rendered =
    if converter.matches(ext)
      converter.convert(post.content)
    else
      post.content
    end
  result = PostEditorial.compute(rendered, post, post.site)
  $stderr.puts "[editorial] #{File.basename(post.relative_path)}: hero_src=#{result['hero_src'].inspect} lede=#{result['lede_html'] ? result['lede_html'][0,40].inspect : 'nil'}"
  post.data['editorial'] = result
  post.data['editorial']['rendered_html'] = rendered
rescue => e
  $stderr.puts "[editorial] ERROR on #{File.basename(post.relative_path)}: #{e.class}: #{e.message}"
  $stderr.puts e.backtrace.first(3).join("\n")
end

# Provide a "force registration" of a tiny filter set as a belt-and-braces
# fallback for anyone using the helpers from non-post pages. These mirror
# the hook-attached `editorial.*` values but compute on demand.
module PostHelpersFilters
  def post_categories_normalized(input)
    return [] if input.nil?
    return input.flatten.map(&:to_s).map(&:strip).reject(&:empty?) if input.is_a?(Array)
    input.to_s.split(',').map(&:strip).reject(&:empty?)
  end

  def asset_exists(input)
    return false if input.nil? || input.to_s.empty?
    return false unless defined?(@context) && @context
    rel = input.to_s.sub(%r{\A/}, '')
    src = @context.registers[:site]&.source
    return false if src.nil?
    File.file?(File.join(src, rel))
  end
end

Liquid::Template.register_filter(PostHelpersFilters)
