# -*- encoding: utf-8 -*-
require File.expand_path("../lib/mongoid/nested_serialization/version", __FILE__)

Gem::Specification.new do |s|
  s.authors       = ["Ryan Townsend"]
  s.email         = ["ryan@ryantownsend.co.uk"]
  s.description   = %q{Loads nested Mongoid documents using a JSON serialization}
  s.summary       = s.description
  s.homepage      = "https://github.com/ryantownsend/mongoid-nested-serialization"
  s.license       = "MIT"

  s.files         = `git ls-files`.split($\)
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(spec|features)/})
  s.name          = "mongoid-nested-serialization"
  s.require_paths = ["lib"]
  s.version       = Mongoid::NestedSerialization::VERSION
  
  s.add_dependency "mongoid"
  s.add_dependency "multi_json"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "foreman"
end
