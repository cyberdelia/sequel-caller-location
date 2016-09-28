require 'bundler'
Bundler.require

require 'simplecov'
SimpleCov.start do
  add_filter('spec/')
end

require 'sequel'
require 'sequel/extensions/comments'

RSpec.configure do |config|
  config.order = 'random'

  config.before(:suite) do
    Sequel::Model.plugin(:schema)
    Sequel.connect('sqlite:/')
  end

  config.around(:each) do |example|
    Sequel::Model.db.transaction(rollback: :always) { example.run }
  end
end
