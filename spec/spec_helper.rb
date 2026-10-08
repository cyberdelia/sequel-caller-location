# frozen_string_literal: true

require 'bundler'
Bundler.require

require 'simplecov'
SimpleCov.start do
  skip('spec/')
end

require 'sequel'
require 'sequel/extensions/caller_location'

RSpec.configure do |config|
  config.order = 'random'
end
