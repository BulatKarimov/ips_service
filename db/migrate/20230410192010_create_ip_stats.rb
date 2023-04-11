# frozen_string_literal: true

ROM::SQL.migration do
  change do
    Hanami.app['clickhouse.connection'].create_table(:ip_stats, primary_key: 'id', engine: 'MergeTree() PARTITION BY toYYYYMMDD(timestamp) ORDER BY (id, ip_address, timestamp)') do |t|
      t.String :uid, default: "UUIDNum()"
      t.String :ip_address
      t.DateTime :timestamp, 'UTC'
      t.Float32 :rtt
    end
  end
end
