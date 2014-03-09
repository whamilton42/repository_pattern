Bundler.require
require 'active_support/core_ext/numeric/time'

DB = Sequel.connect('postgres://localhost/repository_pattern_test')

RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end