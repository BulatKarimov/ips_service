# frozen_string_literal: true

source 'https://rubygems.org'

gem 'dry-types', '~> 1.0', '>= 1.6.1'
gem 'hanami', '~> 2.0'
gem 'hanami-controller', '~> 2.0'
gem 'hanami-router', '~> 2.0'
gem 'hanami-validations', '~> 2.0'
gem 'puma'
gem 'rake'

gem 'click_house'
gem 'pg'
gem 'redis'
gem 'rom', '~> 5.3'
gem 'rom-factory'
gem 'rom-sql', '~> 3.6'
gem 'sequel_pg'

gem 'sidekiq', '~> 6.5'
gem 'sidekiq-cron'

gem 'ipaddress'
gem 'net-ping'
gem 'oj'
gem 'parallel'

group :development, :test do
  gem 'dotenv'
  gem 'rubocop'
  gem 'simplecov'
end

group :cli, :development do
  gem 'hanami-reloader'
end

group :cli, :development, :test do
  gem 'database_cleaner-sequel'
  gem 'hanami-rspec'
end

group :development do
  gem 'byebug'
  gem 'guard-puma', '~> 0.8'
end

group :test do
  gem 'rack-test'
end
