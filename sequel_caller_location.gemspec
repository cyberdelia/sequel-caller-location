# frozen_string_literal: true

Gem::Specification.new do |gem|
  gem.authors       = ['Timothée Peignier']
  gem.email         = ['timothee.peignier@tryphon.org']
  gem.description   = 'Add caller location as SQL comments'
  gem.summary       = 'Add caller location as SQL comments.'
  gem.homepage      = 'http://rubygems.org/gems/sequel_caller_location'
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'sequel_caller_location'
  gem.require_paths = ['lib']
  gem.version       = '0.3.0'

  gem.add_runtime_dependency 'sequel', '>= 4.39.0'

  gem.add_development_dependency 'rspec', '~> 3.9', '>= 3.9.0'
  gem.add_development_dependency 'rubocop', '~> 0.83', '>= 0.83.0'
  gem.add_development_dependency 'rubocop-rspec', '>= 1.39.0', '~> 1.43.1'
  gem.add_development_dependency 'simplecov', '~> 0.18.5'
end
