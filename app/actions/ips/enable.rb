# frozen_string_literal: true

require 'byebug'
module IpsService
  module Actions
    module Ips
      class Enable < Ips::Action
        def handle(request, response)
          if ip = ip_repo.enable(request.params[:id])
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
