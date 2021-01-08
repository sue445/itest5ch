lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "itest5ch/version"

Gem::Specification.new do |spec|
  spec.name          = "itest5ch"
  spec.version       = Itest5ch::VERSION
  spec.authors       = ["sue445"]
  spec.email         = ["sue445@sue445.net"]

  spec.summary       = "5ch (a.k.a. 2ch) reader via itest.5ch.net"
  spec.description   = "5ch (a.k.a. 2ch) reader via itest.5ch.net"
  spec.homepage      = "https://github.com/sue445/itest5ch"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) {|f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.5.0"

  spec.add_dependency "hpricot"
  spec.add_dependency "htmlentities"

  spec.add_development_dependency "activesupport"
  spec.add_development_dependency "bundler", ">= 1.16"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "onkcop", "1.0.0.0"
  spec.add_development_dependency "rake", ">= 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-its"
  spec.add_development_dependency "rspec-parameterized"
  spec.add_development_dependency "rubocop", "1.8.0"
  spec.add_development_dependency "rubocop_auto_corrector"
  spec.add_development_dependency "rubocop-performance", "1.9.2"
  spec.add_development_dependency "rubocop-rspec", "2.1.0"
  spec.add_development_dependency "simplecov", "< 0.18.0"
  spec.add_development_dependency "unparser", ">= 0.4.5"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "yard"
end
