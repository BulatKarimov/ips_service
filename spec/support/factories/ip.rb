# frozen_string_literal: true

Factory.define(:ip) do |f|
  f.ip_address { '8.8.8.8' }
  f.enabled true

  f.trait :disabled do |t|
    t.enabled false
  end
end