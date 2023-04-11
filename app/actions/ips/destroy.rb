# frozen_string_literal: true

module IpsService
  module Actions
    module Ips
      class Destroy < Ips::Action
        def handle(request, response)
          if ip_repo.destroy(request.params[:id])
            response.status = :no_content
            response.body = {}.to_json
          else
            response.status = :not_found
            response.body = { errors: 'ip not found' }.to_json
          end
        end
      end
    end
  end
end
