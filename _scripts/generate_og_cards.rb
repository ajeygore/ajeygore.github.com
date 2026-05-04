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
require 'zlib'

ROOT = File.expand_path('..', __dir__)
POSTS_DIR = File.join(ROOT, 'collections', '_posts')
OUT_DIR = File.join(ROOT, 'assets', 'images', 'blog', 'og')
TEMPLATE = File.join(ROOT, '_data', 'og_template.html')
PHOTO = File.join(ROOT, 'assets', 'images', 'blog_sketch.png')
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

  # Crop a PNG in place to the top `new_height` rows. Pure stdlib (zlib + crc32),
  # so we don't rely on sips/ImageMagick. Handles RGB and RGBA, all 5 PNG filter
  # types. Replaces sips, which silently filled with black on out-of-bounds offsets.
  def crop_png_top!(path, new_height)
    data = File.binread(path)
    raise "not a PNG: #{path}" unless data.byteslice(0, 8) == "\x89PNG\r\n\x1A\n".b

    pos = 8
    ihdr = nil
    idat = String.new(encoding: 'ASCII-8BIT')
    other = []
    while pos < data.bytesize
      length = data.byteslice(pos, 4).unpack1('N')
      type = data.byteslice(pos + 4, 4)
      payload = data.byteslice(pos + 8, length)
      pos += 12 + length
      case type
      when 'IHDR' then ihdr = payload
      when 'IDAT' then idat << payload
      when 'IEND' then break
      else other << [type, payload]
      end
    end
    raise 'missing IHDR' unless ihdr

    width, height, bit_depth, color_type, _, _, interlace = ihdr.unpack('NNCCCCC')
    raise '8-bit only' unless bit_depth == 8
    raise 'interlaced PNG not supported' if interlace != 0
    bpp = case color_type
          when 0 then 1   # grayscale
          when 2 then 3   # RGB
          when 3 then 1   # palette
          when 4 then 2   # gray + alpha
          when 6 then 4   # RGBA
          else raise "unsupported color_type #{color_type}"
          end
    return if new_height >= height

    raw = Zlib::Inflate.inflate(idat)
    row = 1 + width * bpp
    raise 'malformed pixel buffer' if raw.bytesize != height * row

    decoded = decode_rows(raw, width, height, bpp, row)
    cropped_decoded = decoded.byteslice(0, new_height * width * bpp)
    refiltered = filter_rows(cropped_decoded, width, new_height, bpp)
    new_idat = Zlib::Deflate.deflate(refiltered, Zlib::DEFAULT_COMPRESSION)

    new_ihdr = [width, new_height, bit_depth, color_type, 0, 0, 0].pack('NNCCCCC')

    out = String.new(encoding: 'ASCII-8BIT')
    out << "\x89PNG\r\n\x1A\n".b
    out << build_chunk('IHDR', new_ihdr)
    other.each { |t, p| out << build_chunk(t, p) }
    out << build_chunk('IDAT', new_idat)
    out << build_chunk('IEND', '')

    File.binwrite(path, out)
  end

  def build_chunk(type, payload)
    [payload.bytesize].pack('N') + type + payload + [Zlib.crc32(type + payload)].pack('N')
  end

  # Decode all rows, stripping filter bytes and producing raw pixel bytes.
  def decode_rows(raw, width, height, bpp, row)
    out = String.new(capacity: height * width * bpp, encoding: 'ASCII-8BIT')
    prev_decoded = ("\0".b * (width * bpp))
    height.times do |y|
      filter = raw.getbyte(y * row)
      filtered = raw.byteslice(y * row + 1, width * bpp).bytes
      decoded = Array.new(width * bpp, 0)
      filtered.each_with_index do |val, i|
        left = i >= bpp ? decoded[i - bpp] : 0
        up = prev_decoded.getbyte(i) || 0
        upleft = i >= bpp ? (prev_decoded.getbyte(i - bpp) || 0) : 0
        recon = case filter
                when 0 then val
                when 1 then val + left
                when 2 then val + up
                when 3 then val + ((left + up) >> 1)
                when 4 then val + paeth(left, up, upleft)
                else raise "unknown filter #{filter}"
                end
        decoded[i] = recon & 0xff
      end
      pack = decoded.pack('C*')
      out << pack
      prev_decoded = pack
    end
    out
  end

  # Re-encode decoded rows with all filter bytes set to 0 (None). Slightly less
  # compressed than optimal filter selection but trivial and safe.
  def filter_rows(decoded, width, height, bpp)
    rowbytes = width * bpp
    out = String.new(capacity: height * (1 + rowbytes), encoding: 'ASCII-8BIT')
    height.times do |y|
      out << "\x00".b
      out << decoded.byteslice(y * rowbytes, rowbytes)
    end
    out
  end

  def paeth(a, b, c)
    p = a + b - c
    pa = (p - a).abs
    pb = (p - b).abs
    pc = (p - c).abs
    return a if pa <= pb && pa <= pc
    return b if pb <= pc
    c
  end

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
        '--window-size=1200,720', '--force-device-scale-factor=2',
        '--default-background-color=fafafaff',
        "--screenshot=#{png_path}", "file://#{html_path}"
      ]
      ok = system(*cmd, out: File::NULL, err: File::NULL)
      raise "Chrome render failed for #{slug}" unless ok && File.exist?(png_path)

      crop_png_top!(png_path, 1260)

      FileUtils.cp(png_path, out_path)
    end
  end
end

OgCardGenerator.new.run if __FILE__ == $PROGRAM_NAME
