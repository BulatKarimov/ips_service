# frozen_string_literal: true

module IpsService
  module Actions
    module Ips
      class Destroy < Ips::Action
        def handle(request, response)
          #TODO check ip exists
          ip_repo.destroy(request.params[:id])

          response.status = :no_content
          response.body = {}.to_json
        end
      end
    end
  end
end
