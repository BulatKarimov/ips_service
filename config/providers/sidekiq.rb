Hanami.app.register_provider(:sidekiq, namespace: true) do
  prepare do
    require "sidekiq"
    # require "sidekiq-scheduler"
    # require "sidekiq-cron"
  end

  start do
    Sidekiq.configure_client do |config|
      config.redis = {url: target["settings"].redis_url}
    end

    Sidekiq.configure_server do |config|
      config.redis = {url: target["settings"].redis_url}
      # config.on(:startup) do
      #   # Sidekiq.schedule = YAML.load_file(File.expand_path("../config/sidekiq.yml", __dir__))
      #   Sidekiq::Scheduler.reload_schedule!
      # end

      # schedule_file = "./config/sidekiq-cron.yml"
      #
      # if File.exist?(schedule_file)
      #   Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
      # end
    end
  end
end