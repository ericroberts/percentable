# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'percentable/version'

Gem::Specification.new do |spec|
  spec.name          = "percentable"
  spec.version       = Percentable::VERSION
  spec.authors       = ["Eric Roberts"]
  spec.email         = ["ericroberts@gmail.com"]
  spec.summary       = "Small gem to make working with percents easier."
  spec.description   = "Small gem to make working with percents easier. Includes methods to make selected rails attributes return percents."
  spec.homepage      = "https://github.com/ericroberts/percentable"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "money"
end
