# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'terraforming/dnsimple/version'

Gem::Specification.new do |spec|
  spec.name          = "terraforming-dnsimple"
  spec.version       = Terraforming::DNSimple::VERSION
  spec.authors       = ["Daisuke Fujita"]
  spec.email         = ["dtanshi45@gmail.com"]

  spec.summary       = %q{Terraforming extension for DNSimple}
  spec.description   = %q{Terraforming extension for DNSimple}
  spec.homepage      = "https://github.com/dtan4/terraforming-dnsimple"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "dnsimple", "= 2.0.0.alpha5"
  spec.add_dependency "terraforming"
  spec.add_dependency "thor"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "codeclimate-test-reporter"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "terminal-notifier-guard"
  spec.add_development_dependency "webmock"
end
