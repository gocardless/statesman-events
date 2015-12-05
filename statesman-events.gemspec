lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'statesman/events/version'

Gem::Specification.new do |spec|
  spec.name          = "statesman-events"
  spec.version       = Statesman::Events::VERSION
  spec.authors       = ["Grey Baker"]
  spec.email         = ["developers@gocardless.com"]
  spec.description   = %q{Event support for Statesman}
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/gocardless/statesman-events"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency             "statesman",     ">= 1.3"

  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec",         "~> 3.1"
  spec.add_development_dependency "rspec-its",     "~> 1.1"
  spec.add_development_dependency "rubocop",       "~> 0.30.0"
end
