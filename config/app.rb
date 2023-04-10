# frozen_string_literal: true

require 'hanami'

module IpsService
  class App < Hanami::App
    config.middleware.use :body_parser, :json

    environment(:development) do
      config.logger.stream = $stdout

      config.logger.options[:colorize] = true

      config.logger.template = <<~TMPL
        [<blue>%<progname>s</blue>] [%<severity>s] [<green>%<time>s</green>] %<message>s %<payload>s
      TMPL
    end
  end
end
