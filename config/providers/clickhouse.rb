# frozen_string_literal: true

Hanami.app.register_provider :clickhouse, namespace: true do
  prepare do
    require 'click_house'

    class Dry::Logger::Dispatcher
      def debug?
        false
      end
    end

    config = ClickHouse.config do |config|
      config.logger = Hanami.logger
      config.adapter = :net_http
      config.database = "ips_service_development"
      config.url = target['settings'].clickhouse_url
      config.timeout = 60
      config.open_timeout = 3
      config.ssl_verify = false
      # set to true to symbolize keys for SELECT and INSERT statements (type casting)
      config.symbolize_keys = false
      config.headers = {}

      # if you use HTTP basic Auth
      config.username = target['settings'].clickhouse_username
      config.password = target['settings'].clickhouse_password

      # if you want to add settings to all queries
      config.global_params = { mutations_sync: 1 }

      # choose a ruby JSON parser (default one)
      config.json_parser = ClickHouse::Middleware::ParseJson

      # JSON.dump (default one)
      config.json_serializer = ClickHouse::Serializer::JsonSerializer
    end

    register 'config', config
  end

  start do
    register 'connection', ClickHouse::Connection.new(target['clickhouse.config'])
  end
end
