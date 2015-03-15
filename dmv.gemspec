# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dmv/version'

Gem::Specification.new do |spec|
  spec.name          = "dmv"
  spec.version       = DMV::VERSION
  spec.authors       = ["Robert Ross"]
  spec.email         = ["robert@creativequeries.com"]

  spec.summary       = "DMV is a library to help get your forms under control"
  spec.description   = "DMV is a library to help get your forms under control"
  spec.homepage      = "http://github.com/bobbytables/dmv"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'uber', '~> 0.0.13'
  spec.add_dependency 'middleware', '~> 0.1.0'

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
end
