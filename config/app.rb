# frozen_string_literal: true

require 'hanami'

module IpsService
  class App < Hanami::App
    config.middleware.use :body_parser, :json
  end
end
