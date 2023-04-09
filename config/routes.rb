# frozen_string_literal: true

module IpsService
  class Routes < Hanami::Routes
    root { "Hello from Hanami" }

    post "/ips", to: "ips.create"
    post "/ips/:id/enable", to: "ips.enable"
    post "/ips/:id/disable", to: "ips.disable"
  end
end
