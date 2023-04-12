# frozen_string_literal: true

Hanami.app.register_provider(:sidekiq, namespace: true) do
  prepare do
    require 'sidekiq'
    require 'sidekiq-cron'
  end

  start do
    Sidekiq.configure_client do |config|
      config.redis = {url: target['settings'].redis_url}
    end

    Sidekiq.configure_server do |config|
      config.redis = {url: target['settings'].redis_url}

      schedule_file = './config/sidekiq-cron.yml'

      Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file) if File.exist?(schedule_file)
    end
  end
end
