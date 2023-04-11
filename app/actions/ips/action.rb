# frozen_string_literal: true

module IpsService
  module Actions
    module Ips
      class Action < IpsService::Action
        include Deps['repos.ip_repo']

        private

        # TODO: rm
        def verify_csrf_token?(*)
          false
        end
      end
    end
  end
end
