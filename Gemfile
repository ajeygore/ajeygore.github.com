source 'https://rubygems.org'

# We build with `bundle exec jekyll build` (see .github/workflows/github-pages.yml)
# rather than the github-pages meta-gem — the meta-gem auto-requires plugins via
# :jekyll_plugins group, which has the side effect of forcing safe mode and
# preventing custom Ruby plugins under _plugins/ from loading.
gem 'jekyll', '~> 3.10'
gem 'jekyll-feed'
gem 'jekyll-sitemap'
gem 'jekyll-seo-tag'
gem 'kramdown-parser-gfm'
gem 'nokogiri', '~> 1.18'
gem 'rake'
gem "webrick", "~> 1.7"

# Development only
group :development do
  gem 'jekyll-twitter-plugin'
end
