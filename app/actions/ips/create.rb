# frozen_string_literal: true

module IpsService
  module Actions
    module Ips
      class Create < Ips::Action
        params Params::Create
        handle_exception ROM::SQL::UniqueConstraintError => :handle_pg_uniq_error

        def handle(request, response)
          halt 422, {errors: request.params.errors}.to_json unless request.params.valid?

          ip = ip_repo.create(ip_address: request.params[:ip], enabled: request.params[:enabled])

          response.status = :created
          response.body = ip.to_json
        end

        private

        def handle_pg_uniq_error(request, response, _exception)
          response.status = :unprocessable_entity
          response.format = :json
          response.body = {error: "IP address #{request.params[:ip]} already exists"}.to_json
        end
      end
    end
  end
end
