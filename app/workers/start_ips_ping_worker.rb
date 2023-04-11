require 'sidekiq'

module IpsService
  module Workers
    class StartIpsPingWorker
      include Sidekiq::Worker
      include Deps['repos.ip_repo', 'workers.ips_ping_worker', 'clickhouse.config']

      sidekiq_options queue: :ips_ping_starter, retry: false

      BATCH_SIZE = 100

      def perform
        Hanami.logger.info('Ip addresses ping starting...')

        ip_repo.collect_by(enabled: true).each_batch(size: BATCH_SIZE) do |ips|
          ips_ping_worker.class.perform_async(ips.pluck(:id))
        end
      end
    end
  end
end
