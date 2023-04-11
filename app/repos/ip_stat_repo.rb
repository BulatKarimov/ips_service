# frozen_string_literal: true
require 'securerandom'

module IpsService
  module Repos
    class IpStatRepo
      include Deps['clickhouse.connection']

      def get_stats_in_range(start_time:, end_time:, ip_address:)
        connection.select_one("
          SELECT
            ip_address,
            AVG(if(rtt = 0, NULL, rtt)) AS avg_rtt,
            MIN(if(rtt = 0, NULL, rtt)) AS min_rtt,
            MAX(if(rtt = 0, NULL, rtt)) AS max_rtt,
            quantile(0.5)(rtt) AS median_rtt,
            sqrt(VAR_POP(rtt)) AS std_dev_rtt,
            (countIf(rtt = 0) / count(*)) * 100 AS packet_loss_percent
          FROM ip_stats
          WHERE timestamp >= '#{start_time.to_s}' AND timestamp < '#{end_time.to_s}' AND ip_address = '#{ip_address.to_s}'
          GROUP BY ip_address
        ")
      end

      def batch_insert_ping_results(ping_results)
        # ping_results ||= (0..10).map do
        #   {
        #     uid: SecureRandom.uuid,
        #     rtt: rand/rand,
        #     ip_address: '8.8.8.8',
        #     timestamp: (Time.now.utc).strftime('%Y-%m-%d %H:%M:%S')
        #   }
        # end
        #
        # ping_results += (0..3).map do
        #   {
        #     uid: SecureRandom.uuid.to_s,
        #     rtt: nil,
        #     ip_address: '8.8.8.8',
        #     timestamp: (Time.now.utc).strftime('%Y-%m-%d %H:%M:%S')
        #   }
        # end
        Hanami.logger.info(Hanami.app["settings"].clickhouse_url)
        Hanami.logger.info(connection.config.url.to_s)
        connection.insert('ip_stats', ping_results)
      rescue => e
        Hanami.logger.error(e)
      end
    end
  end
end
