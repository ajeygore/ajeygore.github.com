# Liquid filters used by the editorial post layout:
#   - extract_toc: pull H2/H3 anchors out of rendered post content
#   - first_paragraph: pull the first <p> from rendered content (for the drop-cap lede)
#   - content_without_first_paragraph: render the post body minus the lede paragraph
#   - reading_minutes: integer reading time
#   - post_categories_normalized: array, even if frontmatter is a comma string
#   - has_lead_image / lead_image_url: hero resolution (raster lead_image > OG card auto > nil)

require 'nokogiri'

module PostHelpers
  WORDS_PER_MINUTE = 220

  def reading_minutes(input)
    return 0 if input.nil?
    text = input.is_a?(String) ? input : input.to_s
    text = strip_html_for_count(text)
    words = text.split(/\s+/).reject(&:empty?).length
    [(words.to_f / WORDS_PER_MINUTE).ceil, 1].max
  end

  def word_count(input)
    return 0 if input.nil?
    text = strip_html_for_count(input.to_s)
    text.split(/\s+/).reject(&:empty?).length
  end

  def extract_toc(input)
    return '[]' if input.nil? || input.empty?
    doc = Nokogiri::HTML.fragment(input.to_s)
    items = []
    doc.css('h2, h3').each do |h|
      next if h['data-toc-skip']
      level = h.name == 'h2' ? 2 : 3
      id = h['id']
      next unless id && !id.empty?
      title = h.text.strip
      items << { level: level, id: id, title: title }
    end
    items.to_json
  end

  def lede_paragraph(input)
    return '' if input.nil? || input.empty?
    doc = Nokogiri::HTML.fragment(input.to_s)
    strip_epigraph_from(doc)
    p = pick_lede_paragraph_from(doc)
    return '' if p.nil?
    p.inner_html
  end

  # Pull the body-embedded epigraph (legacy migration left these as inline
  # <div class="post-epigraph">) so the lede include can render it once,
  # above the lede, instead of letting it land mid-content.
  def extract_epigraph(input)
    return '' if input.nil? || input.empty?
    doc = Nokogiri::HTML.fragment(input.to_s)
    div = doc.at_css('div.post-epigraph, aside.post-epigraph')
    return '' if div.nil?
    inner = div.at_css('p')
    (inner ? inner.inner_html : div.inner_html).strip
  end

  # Returns the content with both the lede paragraph and any embedded
  # epigraph div removed — these are rendered separately by the layout.
  def content_without_lede(input)
    return '' if input.nil? || input.empty?
    doc = Nokogiri::HTML.fragment(input.to_s)
    strip_epigraph_from(doc)
    p = pick_lede_paragraph_from(doc)
    p&.remove
    doc.to_html
  end

  def post_categories_normalized(input)
    return [] if input.nil?
    if input.is_a?(Array)
      input.flatten.map(&:to_s).map(&:strip).reject(&:empty?)
    else
      input.to_s.split(',').map(&:strip).reject(&:empty?)
    end
  end

  # True if the given site-relative path resolves to a real file on disk.
  # Used by post-hero.html to fall back from a missing lead_image to the OG card.
  def asset_exists(input)
    return false if input.nil? || input.to_s.empty?
    rel = input.to_s.sub(%r{\A/}, '')
    source = @context.registers[:site].source
    File.file?(File.join(source, rel))
  end

  private

  # A paragraph is a good lede when:
  #   - it's the first direct child <p>
  #   - it's plain prose (no img/figure as sole content)
  #   - it has at least ~60 characters of text (skip salutations like "Dear CTO,")
  def pick_lede_paragraph(html)
    pick_lede_paragraph_from(Nokogiri::HTML.fragment(html))
  end

  def pick_lede_paragraph_from(doc)
    # css('> p') doesn't work on a Nokogiri fragment (no parent); walk children.
    p = doc.children.find { |c| c.element? && c.name == 'p' }
    return nil if p.nil?
    if p.css('img').any? && p.text.strip.length < 20
      return nil
    end
    return nil if p.text.strip.length < 60
    p
  end

  def strip_html_for_count(html)
    html.gsub(/<[^>]+>/, ' ').gsub(/\s+/, ' ').strip
  end

  def strip_epigraph_from(doc)
    doc.css('div.post-epigraph, aside.post-epigraph').each(&:remove)
  end
end

Liquid::Template.register_filter(PostHelpers)
