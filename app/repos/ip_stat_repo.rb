# frozen_string_literal: true

require 'securerandom'

module IpsService
  module Repos
    class IpStatRepo
      include Deps['clickhouse.connection']

      def get_stats_info(start_time:, end_time:, ip_address:)
        statement = connection.prepare("
          SELECT
            ip_address,
            AVG(if(rtt = 0, NULL, rtt)) AS avg_rtt,
            MIN(if(rtt = 0, NULL, rtt)) AS min_rtt,
            MAX(if(rtt = 0, NULL, rtt)) AS max_rtt,
            quantile(0.5)(if(rtt > 0, rtt, NULL)) AS median_rtt,
            sqrt(VAR_POP(if(rtt > 0, rtt, NULL))) AS std_dev_rtt,
            (countIf(rtt = 0) / count(*)) * 100 AS packet_loss_percent
          FROM ip_stats
          WHERE timestamp >= ? AND timestamp < ? AND ip_address = ?
        ")

        statement.execute(start_time, end_time, ip_address)
      end

      def batch_insert_ping_results(ping_results)
        connection.insert('ip_stats', ping_results)
      end
    end
  end
end
