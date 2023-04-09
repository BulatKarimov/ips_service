# frozen_string_literal: true

require 'byebug'
module IpsService
  module Actions
    module Ips
      class Enable < Ips::Action
        def handle(request, response)
          # TODO: check ip exists
          ip = ip_repo.enable(request.params[:id])

          response.status = :ok
          response.body = ip.to_json
        end
      end
    end
  end
end
