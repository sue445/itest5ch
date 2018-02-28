
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "itest5ch/version"

Gem::Specification.new do |spec|
  spec.name          = "itest5ch"
  spec.version       = Itest5ch::VERSION
  spec.authors       = ["sue445"]
  spec.email         = ["sue445@sue445.net"]

  spec.summary       = %q{5ch reader via http://itest.5ch.net/}
  spec.description   = %q{5ch reader via http://itest.5ch.net/}
  spec.homepage      = "https://github.com/sue445/itest5ch"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "onkcop", "0.52.1.1"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "0.52.1"
  spec.add_development_dependency "rubocop-rspec", "1.23.0"
end
