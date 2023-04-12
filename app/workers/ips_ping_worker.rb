# frozen_string_literal: true

require 'sidekiq'
require 'securerandom'
require 'parallel'

module IpsService
  module Workers
    class IpsPingWorker
      include Sidekiq::Worker
      include Deps['repos.ip_repo',
                   'repos.ip_stat_repo',
                   'services.ips.ping_ip_address']

      sidekiq_options queue: :ips_ping_worker, retry: false

      def perform(ip_ids)
        Hanami.logger.info("ips_id: #{ip_ids}")

        result = ip_repo.relation.transaction do |_rom|
          ips = ip_repo.collect_by(id: ip_ids).to_a

          Parallel.map_with_index(ips, in_threads: 10) do |ip, thread_index|
            Hanami.logger.info("pinging #{ip[:ip_address]} in thread ##{thread_index}")

            ping_result = ping_ip_address.call(ip[:ip_address])

            next unless ping_result

            ping_result.merge(
              {
                ip_address: ip[:ip_address].to_s,
                uid: SecureRandom.uuid.to_s
              }
            )
          end
        end

        # Hanami.logger.info("ping_result: #{result}")

        # TODO: DTO ???

        ip_stat_repo.batch_insert_ping_results(result.compact)
      rescue ArgumentError => e
        Hanami.logger.error("[#{e}] Can not connect to clickhouse...")
      rescue StandardError => e
        Hanami.logger.error("[#{e.class}] #{e.message}")
      end
    end
  end
end
