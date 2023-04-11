# frozen_string_literal: true

require 'byebug'
require 'ipaddress'

module IpsService
  module Actions
    module Ips
      module Params
        class Create < Hanami::Action::Params
          params do
            optional(:enabled).value(:bool)
            required(:ip).filled(
              :string,
              format?: Regexp.union(IPAddr::RE_IPV4ADDRLIKE,
                                    IPAddr::RE_IPV6ADDRLIKE_FULL,
                                    IPAddr::RE_IPV6ADDRLIKE_COMPRESSED)
            )
          end
        end
      end
    end
  end
end
