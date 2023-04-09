# frozen_string_literal: true

module IpsService
  module Actions
    module Ips
      class Disable < Ips::Action
        def handle(request, response)
          #TODO check ip exists
          ip = ip_repo.disable(request.params[:id])

          response.status = :ok
          response.body = ip.to_json
        end
      end
    end
  end
end
