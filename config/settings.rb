# frozen_string_literal: true

module IpsService
  class Settings < Hanami::Settings
    setting :database_url, constructor: Types::String
    setting :clickhouse_url, constructor: Types::String
    setting :clickhouse_username, constructor: Types::String
    setting :clickhouse_password, constructor: Types::String
    setting :redis_url, constructor: Types::String
  end
end
