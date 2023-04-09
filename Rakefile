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