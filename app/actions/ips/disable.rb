# frozen_string_literal: true

module IpsService
  module Actions
    module Ips
      class Disable < Ips::Action
        def handle(request, response)
          if ip = ip_repo.disable(request.params[:id])
            response.status = :ok
            response.body = ip.to_json
          else
            response.status = :not_found
            response.body = {errors: 'ip not found'}.to_json
          end
        end
      end
    end
  end
end
