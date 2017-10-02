# frozen-string-literal: true

require 'bundler'
Bundler.require

require 'simplecov'
SimpleCov.start do
  add_filter('spec/')
end

require 'sequel'
require 'sequel/extensions/caller_location'

RSpec.configure do |config|
  config.order = 'random'
end
