# frozen_string_literal: true

require 'hanami/rake_tasks'
require 'rom/sql/rake_task'

task :environment do
  require_relative 'config/app'
  require 'hanami/prepare'
end

namespace :db do
  task setup: :environment do
    Hanami.app.prepare(:database)
    ROM::SQL::RakeSupport.env = Hanami.app['database.config']
  end
end


namespace :clickhouse do
  task create: :environment do
    config = Hanami.app['clickhouse.config']
    connection = ClickHouse::Connection.new(config)
    connection.create_database(config.database, if_not_exists: true)
  end
end
