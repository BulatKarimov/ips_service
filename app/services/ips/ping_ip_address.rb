require 'net/ping'

module IpsService
  module Services
    module Ips
      class PingIpAddress
        PING_TIMEOUT = 1

        def self.call(ip_address)
          new.call(ip_address)
        end

        def call(ip_address)
          #TODO ipv6 ping

          net_ping = Net::Ping::External.new(ip_address, nil, PING_TIMEOUT)

          {
            timestamp: Time.now.utc.strftime('%Y-%m-%d %H:%M:%S'),
            rtt: net_ping.ping ? net_ping.duration : nil
          }
        end
      end
    end
  end
end
