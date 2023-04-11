# frozen_string_literal: true

module IpsService
  module Actions
    module Ips
      class Index < Ips::Action
        def handle(_request, response)
          response.body = ip_repo.relation.to_a
          response.status = :ok
        end
      end
    end
  end
end
