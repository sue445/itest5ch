source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in itest5ch.gemspec
gemspec

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create("2.6.0")
  # minitest v5.16.0+ requires ruby 2.6.0+
  gem "minitest", "< 5.16.0"
end

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create("2.7.0")
  # term-ansicolor 1.9.0+ doesn't work on Ruby < 2.7
  gem "term-ansicolor", "< 1.9.0"
end
