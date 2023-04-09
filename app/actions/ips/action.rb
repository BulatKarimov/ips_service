module IpsService
  module Actions
    module Ips
      class Action < IpsService::Action
        include Deps["repos.ip_repo"]
      end
    end
  end
end