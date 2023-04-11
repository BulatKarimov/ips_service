# frozen_string_literal: true

ROM::SQL.migration do
  up do
    create_table :ips do
      primary_key :id
      column :ip_address, String, null: false, index: {unique: true}
      column :enabled, :boolean, default: true, null: false
    end
  end
end
