# frozen_string_literal: true

source 'https://rubygems.org'

gem 'hanami', '~> 2.0'
gem 'hanami-controller', '~> 2.0'
gem 'hanami-router', '~> 2.0'
gem 'hanami-validations', '~> 2.0'
gem 'dry-types', '~> 1.0', '>= 1.6.1'
gem 'puma'
gem 'rake'

gem 'pg'
gem 'rom', '~> 5.3'
gem 'rom-factory'
gem 'rom-sql', '~> 3.6'
gem 'sequel_pg'
gem 'click_house'
gem 'redis'

gem 'sidekiq', '~> 6.5'
gem 'sidekiq-cron'

gem 'net-ping'
gem 'oj'
gem 'parallel'
gem 'ipaddress'

group :development, :test do
  gem 'dotenv'
  gem 'rubocop'
  gem 'simplecov'
end

group :cli, :development do
  gem 'hanami-reloader'
end

group :cli, :development, :test do
  gem 'hanami-rspec'
  gem 'database_cleaner-sequel'
end

group :development do
  gem 'guard-puma', '~> 0.8'
  gem 'byebug'
end

group :test do
  gem 'rack-test'
end
