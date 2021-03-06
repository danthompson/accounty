# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'accounty/version'

Gem::Specification.new do |spec|
  spec.name          = "accounty"
  spec.version       = Accounty::VERSION
  spec.authors       = ["Dan Thompson"]
  spec.email         = ["dwthompson@gmail.com"]
  spec.summary       = "A program to take an entry file, and parse it into actual account numbers."
  spec.homepage      = "https://github.com/danthompson/accounty"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
