# frozen_string_literal: true

Gem::Specification.new do |gem|
  gem.authors       = ['Timothée Peignier']
  gem.email         = ['timothee.peignier@tryphon.org']
  gem.description   = 'Add caller location as SQL comments'
  gem.summary       = 'Add caller location as SQL comments.'
  gem.homepage      = 'https://rubygems.org/gems/sequel_caller_location'
  gem.license       = 'MIT'
  gem.metadata['rubygems_mfa_required'] = 'true'

  gem.files         = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.name          = 'sequel_caller_location'
  gem.require_paths = ['lib']
  gem.version       = '0.4.0'

  gem.required_ruby_version = '>= 2.4'

  gem.add_dependency 'sequel', '>= 4.39.0'
end
