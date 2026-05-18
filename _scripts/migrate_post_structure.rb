#!/usr/bin/env ruby
# Promote #### → ## (h4 was being used as the section break across all essays).
# Convert lone ⸻ paragraphs to <hr class="ornament" />.
# Convert .footnote epigraph divs to <div class="post-epigraph">...</div>.
# Only touches markdown files in collections/_posts/.

require 'fileutils'

POSTS_DIR = File.expand_path('../collections/_posts', __dir__)

def migrate(text)
  # Split frontmatter so we don't touch it
  if text =~ /\A(---\s*\n.*?\n---\s*\n)(.*)\z/m
    fm, body = Regexp.last_match(1), Regexp.last_match(2)
  else
    fm, body = '', text
  end

  out_lines = []
  in_code = false
  body.each_line do |line|
    # Toggle fenced code blocks so we don't munge content inside them
    if line.lstrip.start_with?('```')
      in_code = !in_code
      out_lines << line
      next
    end
    if in_code
      out_lines << line
      next
    end

    # Older posts used h4/h5/h6 as section headers. Normalize all to h2.
    stripped = line.chomp
    if stripped =~ /\A\#{4,6} (.+)\z/
      title = $1.gsub(/\*\*(.+?)\*\*/, '\1') # unwrap surrounding **bold** in headings
      out_lines << "## #{title}\n"
      next
    end

    # Lone ⸻ paragraph → ornament hr
    if line.strip == '⸻'
      out_lines << "<hr class=\"ornament\" />\n"
      next
    end

    out_lines << line
  end

  # Convert .footnote epigraph divs:
  #   <div class="footnote">
  #   <strong>&ldquo;…&rdquo;</strong>
  #   <p/>
  #   </div>
  # → <div class="post-epigraph">…</div>
  joined = out_lines.join
  joined = joined.gsub(
    /<div class="footnote">\s*\n\s*<strong>&ldquo;(.*?)&rdquo;<\/strong>\s*\n\s*<p\/?>\s*\n\s*<\/div>/m
  ) do |_|
    quote = Regexp.last_match(1)
    %(<div class="post-epigraph">\n  <p>#{quote}</p>\n</div>)
  end

  fm + joined
end

changed = 0
Dir.glob(File.join(POSTS_DIR, '*.md')).sort.each do |path|
  before = File.read(path)
  after = migrate(before)
  if before != after
    File.write(path, after)
    changed += 1
    puts "migrated: #{File.basename(path)}"
  end
end

puts "\n#{changed} files changed."
