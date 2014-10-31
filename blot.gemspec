# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'blot/version'

Gem::Specification.new do |spec|
  spec.name          = "blot"
  spec.version       = Blot::VERSION
  spec.authors       = ["Ben A Morgan"]
  spec.email         = ["ben@benmorgan.io"]
  spec.summary       = %q{Blot, a DSL for Ink emails.}
  spec.description   = %q{
    Tired of all those tables in those emails?
    Blot is a DSL that lets you create them with ease and optimized with the Ink email framework.
  }
  spec.homepage      = "https://github.com/BenMorganIO/blot"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'rails', '>= 1'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", '>= 0'
  spec.add_development_dependency "rspec", '~> 3.1.0'
end
