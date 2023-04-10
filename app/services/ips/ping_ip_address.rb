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
          net_ping = Net::Ping::External.new(ip_address, nil, PING_TIMEOUT)

          if net_ping.ping
            {
              rtt: net_ping.duration,
              is_lost: false,
              timestamp: Time.now.to_i
            }
          else
            {
              rtt: nil,
              is_lost: true,
              timestamp: Time.now.to_i
            }
          end


          # ip_address.reduce({}) do |result, ip_address|
          #   puts result
          #   net_ping = Net::Ping::External.new(ip_address)
          #
          #   data = if net_ping.ping
          #            {
          #              rtt: net_ping.duration,
          #              is_lost: false,
          #              timestamp: Time.now.to_i
          #            }
          #          else
          #            {
          #              rtt: nil,
          #              is_lost: true,
          #              timestamp: Time.now.to_i
          #            }
          #          end
          #
          #   puts result
          #   puts data
          #
          #   result[ip_address] = data
        end
      end
    end
  end
end