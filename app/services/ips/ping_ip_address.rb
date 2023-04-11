# frozen_string_literal: true

require 'net/ping'
require 'byebug'

module IpsService
  module Services
    module Ips
      class PingIpAddress
        PING_TIMEOUT = 1

        class UnknownIpAddressFormat < StandardError; end

        def self.call(ip_address)
          new.call(ip_address)
        end

        def call(ip_address)
          ip_address = IPAddr.new(ip_address)

          net_ping = Net::Ping::External.new(ip_address.to_s, nil, PING_TIMEOUT)

          ping = if ip_address.ipv4?
                   net_ping.ping
                 elsif ip_address.ipv6?
                   net_ping.ping6
                 else
                   raise UnknownIpAddressFormat
                 end

          {
            timestamp: Time.now.utc.strftime('%Y-%m-%d %H:%M:%S'),
            rtt: ping ? net_ping.duration : nil
          }
        rescue IPAddr::InvalidAddressError, UnknownIpAddressFormat => e
          Hanami.logger.error("[#{e}] Invalid IP address: #{ip_address}")

          nil
        end
      end
    end
  end
end
