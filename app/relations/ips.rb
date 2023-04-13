# frozen_string_literal: true

module IpsService
  module Relations
    class Ips < ROM::Relation[:sql]
      schema(:ips, infer: true)

      # TODO
      # auto_struct(true)
    end
  end
end
