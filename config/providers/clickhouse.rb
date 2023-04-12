# frozen_string_literal: true

Hanami.app.register_provider :clickhouse, namespace: true do
  prepare do
    require 'click_house'

    module Dry
      module Logger
        class Dispatcher
          def debug?
            false
          end
        end
      end
    end

    config = ClickHouse.config do |config|
      config.logger = Hanami.logger
      config.adapter = :net_http
      config.database = 'ips_service_development'
      config.url = target['settings'].clickhouse_url
      config.timeout = 60
      config.open_timeout = 3
      config.ssl_verify = false
      config.symbolize_keys = false
      config.headers = {}
      config.username = target['settings'].clickhouse_username
      config.password = target['settings'].clickhouse_password
      config.global_params = {mutations_sync: 1}
      config.json_parser = ClickHouse::Middleware::ParseJson
      config.json_serializer = ClickHouse::Serializer::JsonSerializer
    end

    register 'config', config
  end

  start do
    register 'connection', ClickHouse::Connection.new(target['clickhouse.config'])
  end
end
