require 'sidekiq'

module IpsService
  module Workers
    class IpsPingWorker
      include Sidekiq::Job
      include Deps['repos.ip_repo',
                   'services.ips.ping_ip_address']

      def perform(ip_ids)
        #TODO lock
        #
        Hanami.logger.info("ips_id: #{ip_ids}")

        ips = ip_repo.collect_by(id: ip_ids).to_a

        result = ips.map do |ip|
                  [ip[:ip_address].to_s, ping_ip_address.call(ip[:ip_address])]
                end.to_h

        Hanami.logger.info("ping_result: #{result}")

        # ip_stat.insert(result)
      end
    end
  end
end