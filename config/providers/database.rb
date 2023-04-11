# frozen_string_literal: true

Hanami.app.register_provider :database, namespace: true do
  prepare do
    require 'rom'
    require 'click_house'
    require 'oj'

    config = ROM::Configuration.new(:sql, target['settings'].database_url)

    ch_config = ClickHouse.config do |config|
      config.logger = Hanami.logger
      config.adapter = :net_http
      config.database = 'ips_service_development'
      config.url = target['settings']
      config.timeout = 60
      config.open_timeout = 3
      config.ssl_verify = false
      # set to true to symbolize keys for SELECT and INSERT statements (type casting)
      config.symbolize_keys = false
      config.headers = {}

      # or provide connection options separately
      # config.scheme = 'https'
      # config.host = 'https://k8uiq55992.eu-central-1.aws.clickhouse.cloud'
      # config.port = '8443'

      # if you use HTTP basic Auth
      config.username = 'default'
      config.password = '9Pk.HekbZY7AT'

      # if you want to add settings to all queries
      config.global_params = {mutations_sync: 1}

      # choose a ruby JSON parser (default one)
      config.json_parser = ClickHouse::Middleware::ParseJson
      # or Oj parser
      config.json_parser = ClickHouse::Middleware::ParseJsonOj

      # JSON.dump (default one)
      config.json_serializer = ClickHouse::Serializer::JsonSerializer
      # or Oj.dump
      config.json_serializer = ClickHouse::Serializer::JsonOjSerializer
    end

    register 'config', config
    register 'ch_config', ch_config
    register 'db', config.gateways[:default].connection
  end

  start do
    config = target['database.config']

    config.auto_registration(
      target.root.join('app'),
      namespace: 'IpsService::Relations'
    )

    register 'rom', ROM.container(config)
    register 'clickhouse', ClickHouse::Connection.new(target['database.ch_config'])
  end
end
