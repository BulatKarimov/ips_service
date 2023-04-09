# frozen_string_literal: true
require 'byebug'
module IpsService
  module Actions
    module Ips
      class Enable < IpsService::Action
        include Deps["repos.ip_repo"]

        def handle(request, response)
          ip = ip_repo.enable(request.params[:id])

          response.status = 200
          response.body = ip.to_json
        end
      end
    end
  end
end
