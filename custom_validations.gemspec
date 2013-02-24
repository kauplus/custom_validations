# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "custom_validations/version"

Gem::Specification.new do |gem|
  gem.authors       = ["Kauplus Social Commerce"]
  gem.email         = ["suporte@kauplus.com.br"]
  gem.description   = %q{Collection of custom validations for Rails}
  gem.summary       = %q{Adds custom validations code for ActiveModel and javascript code for ClientSideValidations (https://github.com/bcardarella/client_side_validations)}
  gem.homepage      = "https://github.com/kauplus/custom_validations"

  gem.files         = `git ls-files -- {lib/*,vendor/*,*.gemspec}`.split("\n")
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "custom_validations"
  gem.require_paths = ["lib"]
  gem.version       = CustomValidations::VERSION


  #
  # Dependencies
  #
  gem.add_development_dependency 'rails', '>= 3.0'
  gem.add_development_dependency 'rspec'

end
