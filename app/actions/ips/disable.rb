# frozen_string_literal: true

module IpsService
  module Actions
    module Ips
      class Disable < IpsService::Action
        include Deps["repos.ip_repo"]

        def handle(request, response)
          ip = ip_repo.disable(request.params[:id])

          response.status = 200
          response.body = ip.to_json
        end
      end
    end
  end
end
