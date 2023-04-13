# frozen_string_literal: true

# TODO: переделать

module IpsService
  module Relations
    class Ips < ROM::Relation[:sql]
      schema(:ips, infer: true)
    end
  end
end
