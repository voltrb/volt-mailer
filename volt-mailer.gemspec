# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'volt/mailer/version'

Gem::Specification.new do |spec|
  spec.name          = "volt-mailer"
  spec.version       = Volt::Mailer::VERSION
  spec.authors       = ["Ryan Stout"]
  spec.email         = ['ryan@agileproductions.com']
  spec.summary       = %q{A simple way to send e-mail from within a Volt app.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "pony", "~> 1.11"

  spec.add_development_dependency "volt", "~> 0.9.0"
  spec.add_development_dependency "rake"
end
