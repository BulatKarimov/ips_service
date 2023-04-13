# frozen_string_literal: true

module IpsService
  module Relations
    class Ips < ROM::Relation[:sql]
      schema(:ips, infer: true)
    end
  end
end
