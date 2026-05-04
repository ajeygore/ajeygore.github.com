#!/usr/bin/env ruby
# Generate 1200x630 social-preview cards (og:image / twitter:image) for blog posts.
# Pipeline: HTML template -> Chrome headless screenshot (1200x690) -> sips crop to 1200x630.
#
# Run from repo root:
#   bundle exec rake og        # generate cards for posts that need one
#   bundle exec rake og:clean  # remove all generated cards

require 'yaml'
require 'date'
require 'fileutils'
require 'cgi'
require 'tmpdir'

ROOT = File.expand_path('..', __dir__)
POSTS_DIR = File.join(ROOT, 'collections', '_posts')
OUT_DIR = File.join(ROOT, 'assets', 'images', 'blog', 'og')
TEMPLATE = File.join(ROOT, '_data', 'og_template.html')
PHOTO = File.join(ROOT, 'assets', 'images', 'ajey_bw.png')
CHROME = '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'

class OgCardGenerator
  RASTER_EXTS = %w[.png .jpg .jpeg].freeze

  def initialize
    @template = File.read(TEMPLATE)
    @generated = 0
    @skipped = 0
  end

  def run
    abort "Chrome not found at #{CHROME}" unless File.exist?(CHROME)
    abort "Template not found at #{TEMPLATE}" unless File.exist?(TEMPLATE)
    abort "Photo not found at #{PHOTO}" unless File.exist?(PHOTO)
    FileUtils.mkdir_p(OUT_DIR)

    Dir.glob(File.join(POSTS_DIR, '*.md')).sort.each { |path| process(path) }
    puts "\nDone. Generated: #{@generated}. Skipped: #{@skipped}."
  end

  private

  def process(post_path)
    front = parse_front_matter(post_path)
    return unless front

    title = front['title'].to_s.strip
    if title.empty?
      warn "  ! no title in #{File.basename(post_path)}, skipping"
      return
    end

    if front['lead_image'] && raster_lead_image?(front['lead_image'])
      @skipped += 1
      return
    end

    slug = slug_from_filename(post_path)
    out_path = File.join(OUT_DIR, "#{slug}.png")

    if up_to_date?(out_path, post_path)
      @skipped += 1
      return
    end

    render(title, slug, out_path)
    @generated += 1
    puts "  + #{slug}.png"
  end

  def parse_front_matter(path)
    text = File.read(path)
    return nil unless text.start_with?('---')
    parts = text.split(/^---\s*$/, 3)
    return nil if parts.size < 3
    YAML.safe_load(parts[1], permitted_classes: [Date, Time]) || {}
  rescue Psych::SyntaxError => e
    warn "  ! YAML error in #{File.basename(path)}: #{e.message}"
    nil
  end

  def raster_lead_image?(value)
    ext = File.extname(value.to_s).downcase
    RASTER_EXTS.include?(ext)
  end

  def slug_from_filename(path)
    File.basename(path, '.md').sub(/^\d{4}-\d{2}-\d{2}-/, '').downcase
  end

  def up_to_date?(out_path, post_path)
    return false unless File.exist?(out_path)
    out_mtime = File.mtime(out_path)
    [post_path, TEMPLATE, PHOTO].all? { |dep| File.mtime(dep) <= out_mtime }
  end

  def title_class(title)
    n = title.length
    return 's1' if n <= 28
    return 's2' if n <= 50
    's3'
  end

  def render(title, slug, out_path)
    html = @template
      .gsub('{{TITLE}}', CGI.escapeHTML(title))
      .gsub('{{TITLE_CLASS}}', title_class(title))
      .gsub('{{IMAGE_PATH}}', "file://#{PHOTO}")

    Dir.mktmpdir('ogcard-') do |tmp|
      html_path = File.join(tmp, 'card.html')
      png_path = File.join(tmp, 'card.png')
      File.write(html_path, html)

      cmd = [
        CHROME, '--headless=new', '--disable-gpu', '--hide-scrollbars',
        '--window-size=1200,690', '--force-device-scale-factor=2',
        '--default-background-color=fafafaff',
        "--screenshot=#{png_path}", "file://#{html_path}"
      ]
      ok = system(*cmd, out: File::NULL, err: File::NULL)
      raise "Chrome render failed for #{slug}" unless ok && File.exist?(png_path)

      ok = system('sips', '-c', '1260', '2400', '--cropOffset', '-60', '0',
                  png_path, out: File::NULL, err: File::NULL)
      raise "sips crop failed for #{slug}" unless ok

      FileUtils.cp(png_path, out_path)
    end
  end
end

OgCardGenerator.new.run if __FILE__ == $PROGRAM_NAME
