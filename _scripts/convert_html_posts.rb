#!/usr/bin/env ruby
# Convert HTML posts in collections/_posts/ to markdown.
# Two flavors handled:
#   1. Early hand-written fragments (have frontmatter, body is plain HTML)
#   2. Medium full-document exports (full <html>, no frontmatter)

require 'nokogiri'
require 'date'
require 'fileutils'

POSTS_DIR = File.expand_path('../collections/_posts', __dir__)

DUPLICATES_TO_DELETE = [
  '2019-04-26_A-pit-stop-6fcfcc3a2580.html',
  '2020-07-30_Good-byes-are-tough--but-this-isn-t-a-good-bye-c7f0b09e3a8c.html'
]

def slugify(s)
  s.downcase
   .gsub(/[^a-z0-9\s\-]/, '')
   .gsub(/\s+/, '-')
   .gsub(/-+/, '-')
   .gsub(/^-|-$/, '')
end

def html_to_markdown(node, ctx = {})
  return '' if node.nil?
  out = +''
  node.children.each do |child|
    out << render_node(child, ctx)
  end
  out
end

def render_node(node, ctx = {})
  case node.type
  when Nokogiri::XML::Node::TEXT_NODE
    # Normalize non-breaking spaces to regular spaces so emphasis-trimming works
    return node.content.gsub(/[\u00A0\u2000-\u200A\u202F\u205F\u3000]/, " ").gsub(/[\u200B-\u200D\uFEFF]/, "")
  when Nokogiri::XML::Node::COMMENT_NODE
    return ''
  end

  name = node.name.downcase

  case name
  when 'h1'
    "\n\n# #{node.text.strip}\n\n"
  when 'h2'
    "\n\n## #{node.text.strip}\n\n"
  when 'h3'
    "\n\n## #{node.text.strip}\n\n"
  when 'h4'
    "\n\n### #{node.text.strip}\n\n"
  when 'h5', 'h6'
    "\n\n#### #{node.text.strip}\n\n"
  when 'p'
    inner = html_to_markdown(node, ctx).strip
    return '' if inner.empty?
    "\n\n#{inner}\n\n"
  when 'strong', 'b'
    inner = html_to_markdown(node, ctx)
    return '' if inner.strip.empty?
    leading  = inner[/\A\s*/]
    trailing = inner[/\s*\z/]
    "#{leading}**#{inner.strip}**#{trailing}"
  when 'em', 'i'
    inner = html_to_markdown(node, ctx)
    return '' if inner.strip.empty?
    leading  = inner[/\A\s*/]
    trailing = inner[/\s*\z/]
    "#{leading}*#{inner.strip}*#{trailing}"
  when 'a'
    text = html_to_markdown(node, ctx)
    href = node['href'] || ''
    return text if href.empty?
    return text if text.strip.empty?
    leading  = text[/\A\s*/]
    trailing = text[/\s*\z/]
    "#{leading}[#{text.strip}](#{href})#{trailing}"
  when 'br'
    "\n"
  when 'hr'
    "\n\n---\n\n"
  when 'blockquote'
    inner = html_to_markdown(node, ctx).strip
    classes = node['class'].to_s
    prefix = classes.include?('pullquote') ? '> ' : '> '
    quoted = inner.split("\n").map { |l| "#{prefix}#{l}" }.join("\n")
    "\n\n#{quoted}\n\n"
  when 'ul'
    items = node.css('> li').map { |li| "- #{html_to_markdown(li, ctx).strip.gsub(/\n+/, ' ')}" }.join("\n")
    "\n\n#{items}\n\n"
  when 'ol'
    items = node.css('> li').each_with_index.map { |li, i| "#{i + 1}. #{html_to_markdown(li, ctx).strip.gsub(/\n+/, ' ')}" }.join("\n")
    "\n\n#{items}\n\n"
  when 'figure'
    img = node.at_css('img')
    caption_node = node.at_css('figcaption')
    return '' if img.nil?
    alt = img['alt'].to_s.empty? ? 'Image' : img['alt']
    src = img['src'] || ''
    md = "\n\n![#{alt}](#{src})\n"
    if caption_node
      cap_text = html_to_markdown(caption_node, ctx).strip
      md << "*#{cap_text}*\n" unless cap_text.empty?
    end
    md << "\n"
    md
  when 'img'
    alt = node['alt'].to_s.empty? ? 'Image' : node['alt']
    src = node['src'] || ''
    "\n\n![#{alt}](#{src})\n\n"
  when 'pre'
    code_node = node.at_css('code') || node
    lang = (code_node['class'] || '').sub(/^language-/, '')
    text = code_node.text
    "\n\n```#{lang}\n#{text}\n```\n\n"
  when 'code'
    "`#{node.text}`"
  when 'div'
    classes = node['class'].to_s
    if classes.include?('CodeRay')
      text = node.text
      "\n\n```\n#{text.strip}\n```\n\n"
    else
      html_to_markdown(node, ctx)
    end
  when 'section', 'article', 'header', 'footer', 'span'
    html_to_markdown(node, ctx)
  when 'iframe', 'script', 'style'
    ''
  else
    html_to_markdown(node, ctx)
  end
end

def cleanup_markdown(md)
  md = md.gsub(/[ \t]+\n/, "\n")              # trailing spaces
  md = md.gsub(/\n{3,}/, "\n\n")               # collapse blank lines
  md = md.gsub(/&nbsp;/, ' ')
  md = md.gsub(/&amp;/, '&')
  md = md.gsub(/&lt;/, '<')
  md = md.gsub(/&gt;/, '>')
  md = md.gsub(/&quot;/, '"')
  md = md.gsub(/&#39;/, "'")
  md = md.gsub(/&hellip;/, '…')
  md = md.gsub(/&mdash;/, '—')
  md = md.gsub(/&ndash;/, '–')
  md.strip + "\n"
end

def parse_frontmatter_and_body(raw)
  if raw =~ /\A---\s*\n(.*?)\n---\s*\n(.*)\z/m
    [Regexp.last_match(1), Regexp.last_match(2)]
  else
    [nil, raw]
  end
end

def convert_fragment(path)
  raw = File.read(path)
  fm, body = parse_frontmatter_and_body(raw)
  doc = Nokogiri::HTML.fragment(body)
  md = html_to_markdown(doc)
  ["---\n#{fm}\n---\n\n", cleanup_markdown(md)]
end

def convert_medium(path, filename)
  raw = File.read(path)
  doc = Nokogiri::HTML(raw)
  title_node = doc.at_css('h1.p-name') || doc.at_css('title')
  raw_title = title_node ? title_node.text.strip : File.basename(filename, '.html')
  # Strip leading "<Title> — " duplication if subtitle h3 echoes h1
  subtitle_node = doc.at_css('section[data-field="subtitle"]')
  subtitle = subtitle_node ? subtitle_node.text.strip : ''
  body_section = doc.at_css('section[data-field="body"]') || doc.at_css('article') || doc
  # Drop the leading h3 graf--title and h4 graf--subtitle that Medium duplicates inside body
  body_section.css('h3.graf--title, h4.graf--subtitle').each(&:remove)
  body_section.css('section.section-divider, div.section-divider, hr.section-divider').each(&:remove)
  body_section.css('footer').each(&:remove)
  md = html_to_markdown(body_section)
  # Derive date from filename prefix YYYY-MM-DD
  date_match = filename.match(/\A(\d{4})-(\d{2})-(\d{2})/)
  date = date_match ? "#{date_match[1]}-#{date_match[2]}-#{date_match[3]}" : Date.today.to_s
  # Build frontmatter
  categories = guess_categories(raw_title)
  desc = subtitle.empty? ? '' : subtitle
  fm = +"---\n"
  fm << "layout: post\n"
  fm << "title: \"#{raw_title.gsub('"', '\\"')}\"\n"
  fm << "date: #{date}\n"
  fm << "published: true\n"
  fm << "categories: [#{categories}]\n"
  fm << "description: \"#{desc.gsub('"', '\\"')}\"\n" unless desc.empty?
  fm << "---\n\n"
  [fm, cleanup_markdown(md)]
end

def guess_categories(title)
  cats = []
  cats << 'Engineering' if title =~ /engineer|software|code|tech|system|server|infrastructure|VPN|TDD|deploy/i
  cats << 'Leadership' if title =~ /leader|principle|culture|team|mentor|grow/i
  cats << 'Gojek' if title =~ /go.?jek/i
  cats << 'Security' if title =~ /security|vulnerab/i
  cats << 'Reflection' if title =~ /musing|good.?bye|thanks|pit.?stop|disappear|insider/i
  cats = ['Essay'] if cats.empty?
  cats.uniq.map { |c| "\"#{c}\"" }.join(', ')
end

def is_full_html_doc?(path)
  head = File.read(path, 4096)
  head =~ /<!DOCTYPE/i || head =~ /<html/i
end

# ---- main ----
Dir.glob(File.join(POSTS_DIR, '*.html')).each do |path|
  filename = File.basename(path)

  if DUPLICATES_TO_DELETE.include?(filename)
    puts "DELETE duplicate: #{filename}"
    File.delete(path)
    next
  end

  if is_full_html_doc?(path)
    puts "MEDIUM: #{filename}"
    fm, md = convert_medium(path, filename)
  else
    puts "FRAGMENT: #{filename}"
    fm, md = convert_fragment(path)
  end

  # Derive a clean output filename: keep date prefix, slugify the rest
  date_match = filename.match(/\A(\d{4})-(\d{2})-(\d{2})[_-]?(.*)\.html\z/)
  if date_match
    date = "#{date_match[1]}-#{date_match[2]}-#{date_match[3]}"
    rest = date_match[4]
    # Strip trailing Medium hash like -abc123def
    rest = rest.gsub(/-[0-9a-f]{8,}$/, '')
    slug = slugify(rest.tr('_', '-'))
    out_name = "#{date}-#{slug}.md"
  else
    out_name = File.basename(filename, '.html') + '.md'
  end
  out_path = File.join(POSTS_DIR, out_name)
  File.write(out_path, fm + md)
  puts "  → #{out_name}"
  File.delete(path)
end

puts "\nDone."
