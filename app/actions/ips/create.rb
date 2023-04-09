# frozen_string_literal: true

module IpsService
  module Actions
    module Ips
      class Create < Ips::Action
        include Deps['repos.ip_repo']

        params Params::Create

        def handle(request, response)
          halt 422, {errors: request.params.errors}.to_json unless request.params.valid?

          # TODO: PG::UniqueViolation rescue
          # TODO convert ip_address string to :inet format
          ip = ip_repo.create(ip_address: request.params[:ip], enabled: request.params[:enabled])

          response.status = :created
          response.body = ip.to_json
        end
      end
    end
  end
end
