require 'sidekiq'

module IpsService
  module Workers
    class StartIpsPingWorker
      include Sidekiq::Job
      include Deps['repos.ip_repo', 'workers.ips_ping_worker']

      BATCH_SIZE = 100

      def perform
        Hanami.logger.info('Ip addresses ping starting...')

        ip_repo.collect_by(enabled: true).each_batch(size: BATCH_SIZE) do |ips|
          ip_ids = ips.pluck(:id)

          ips_ping_worker.perform(ips.pluck(:id))

          # ips_ping_worker.perform_async(ips.pluck(:id))
        end
      end
    end
  end
end