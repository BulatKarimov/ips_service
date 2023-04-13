# frozen_string_literal: true

require 'pathname'
SPEC_ROOT = Pathname(__dir__).realpath.freeze

ENV['HANAMI_ENV'] ||= 'test'
require 'hanami/prepare'

require_relative 'support/rspec'
require_relative 'support/requests'

require 'rom-factory'

require 'database_cleaner-sequel'

Factory = ROM::Factory.configure do |config|
  config.rom = Hanami.app['database.rom']
end

Dir["#{File.dirname(__FILE__)}/support/factories/*.rb"].sort.each {|file| require file }

DatabaseCleaner[:sequel, db: Hanami.app['database.connection']]

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each, type: :database) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
