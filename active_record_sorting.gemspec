# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_record_sorting/version'

Gem::Specification.new do |spec|
  spec.name          = "active_record_sorting"
  spec.version       = ActiveRecordSorting::VERSION
  spec.authors       = ["yratanov"]
  spec.email         = ["organium@gmail.com"]
  spec.description   = 'Simple gem for Rails Active Record sorting'
  spec.summary       = 'Extract you sorting logic to separate object'
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.0'

  spec.add_runtime_dependency "rails", ['>= 3.2']

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "activerecord"
  spec.add_development_dependency "sqlite3"
end
