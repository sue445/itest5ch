source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in itest5ch.gemspec
gemspec

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create("2.5.0")
  # activesupport v6.0.0 requires Ruby v2.5.0+
  gem "activesupport", "< 6.0.0", group: :test
end
