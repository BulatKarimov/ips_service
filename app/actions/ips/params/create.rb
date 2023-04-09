# frozen_string_literal: true

require 'byebug'
require 'ipaddress'

module IpsService
  module Actions
    module Ips
      module Params
        class Create < Hanami::Action::Params
          # TODO: ipv4/ipv6 format check
          params do
            optional(:enabled).value(:bool)
            required(:ip).filled(:string)
          end
        end
      end
    end
  end
end
