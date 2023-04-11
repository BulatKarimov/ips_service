# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq/cron/web'

module IpsService
  class Routes < Hanami::Routes
    root { 'Hello from Hanami' }

    post '/ips', to: 'ips.create'
    post '/ips/:id/enable', to: 'ips.enable'
    post '/ips/:id/disable', to: 'ips.disable'
    delete '/ips/:id', to: 'ips.destroy'
    delete '/ips/:id', to: 'ips.destroy'
    get '/ip_stats', to: 'ip_stats.index'

    mount Sidekiq::Web, at: '/sidekiq'
  end
end
