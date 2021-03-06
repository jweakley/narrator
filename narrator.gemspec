# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'narrator/version'

Gem::Specification.new do |gem|
  gem.name          = 'narrator'
  gem.version       = Narrator::VERSION
  gem.authors       = ['Joe Weakley']
  gem.email         = ['joe.weakley@digitalaugment.com']
  gem.description   = %q{Straightforward and flexable activity tracking for rails.}
  gem.summary       = %q{Straightforward and flexable activity tracking for rails.}
  gem.homepage      = 'https://github.com/jweakley/narrator'
  gem.post_install_message = 'Thanks for installing Narrator!'
  gem.license = 'MIT'

  gem.files         = `git ls-files`.split($RS)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.required_ruby_version = '>= 1.9'

  gem.add_dependency('rails', '~> 3.0')

  gem.add_development_dependency 'rails', '~> 3.0'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rubocop'

end
