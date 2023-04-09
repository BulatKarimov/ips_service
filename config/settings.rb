# frozen_string_literal: true

module IpsService
  class Settings < Hanami::Settings
    # Define your app settings here, for example:
    #
    # setting :my_flag, default: false, constructor: Types::Params::Bool

    setting :database_url, constructor: Types::String
  end
end
