# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.authors       = ['Timothée Peignier']
  gem.email         = ['timothee.peignier@tryphon.org']
  gem.description   = 'Add caller location as SQL comments'
  gem.summary       = 'Add caller location as SQL comments.'
  gem.homepage      = 'http://rubygems.org/gems/sequel_vault'
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'sequel_comments'
  gem.require_paths = ['lib']
  gem.version       = '0.1.1'

  gem.add_runtime_dependency 'sequel', '~> 4.21', '>= 4.21.0'

  gem.add_development_dependency 'rspec', '~> 3.2', '>= 3.2.0'
  gem.add_development_dependency 'simplecov', '~> 0.9.2'
  gem.add_development_dependency 'sqlite3', '~> 1.3', '>= 1.3.10'
end
