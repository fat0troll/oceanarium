# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'oceanarium/version'

Gem::Specification.new do |spec|
  spec.name          = "oceanarium"
  spec.version       = Oceanarium::VERSION
  spec.authors       = ["Valdos Sine", "Delta-Zet LLC"]
  spec.email         = ["iam@toofat.ru"]
  spec.description   = %q{Digital Ocean API wrapper for Ruby/Rails applications}
  spec.summary       = %q{Smart and tiny Digital Ocean API wrapper for Ruby/Rails. For all dirty work used httparty.}
  spec.homepage      = "http://oceanarium.so"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry-remote"
  spec.add_dependency "httparty"
  spec.add_dependency "uri-handler"
end
