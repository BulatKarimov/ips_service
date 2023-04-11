# frozen_string_literal: true

require 'sidekiq'
require 'securerandom'

module IpsService
  module Workers
    class IpsPingWorker
      include Sidekiq::Worker
      include Deps['repos.ip_repo',
                   'repos.ip_stat_repo',
                   'services.ips.ping_ip_address']

      sidekiq_options queue: :ips_ping_worker, retry: false

      def perform(ip_ids)
        # TODO: lock
        Hanami.logger.info("ips_id: #{ip_ids}")

        ips = ip_repo.collect_by(id: ip_ids).to_a

        # TODO: Parallel
        result = ips.map do |ip|
          ping_ip_address.call(ip[:ip_address]).merge(
            {
              ip_address: ip[:ip_address].to_s,
              uid: SecureRandom.uuid.to_s
            }
          )
        end

        Hanami.logger.info("ping_result: #{result}")

        # TODO: DTO ???
        ip_stat_repo.batch_insert_ping_results(result)
      rescue ArgumentError => e
        Hanami.logger.error("[#{e}] Can not connect to clickhouse...")
      rescue StandardError
        Hanami.logger.error('Unknown error')
      end
    end
  end
end
