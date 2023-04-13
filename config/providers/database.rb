# frozen_string_literal: true

Hanami.app.register_provider :database, namespace: true do
  prepare do
    require 'rom'
    require "rom/sql/clickhouse"

    config = ROM::Configuration.new(:sql, target['settings'].database_url)

    register 'config', config
    register 'connection', config.gateways[:default].connection


    config = ROM::Configuration.new(
      :sql,
      "clickhouse://#{settings.clickhouse_username}:#{settings.clickhouse_password}@#{settings.clickhouse_host}:#{settings.clickhouse_port}/#{settings.clickhouse_database}"
    ) do |conf|
      conf.adapter :clickhouse
      conf.use :macros
    end

    register "config", config

    container = ROM.container(config) do |container|
      container.relation(:ip_stats)
    end

    register "container", container
  end

  start do
    config = target['database.config']

    config.auto_registration(
      target.root.join('app'),
      namespace: 'IpsService::Relations'
    )

    register 'rom', ROM.container(config)
  end
end
