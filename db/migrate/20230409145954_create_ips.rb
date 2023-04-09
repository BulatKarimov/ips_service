# frozen_string_literal: true

ROM::SQL.migration do
  up do
    create_table :ips do
      primary_key :id
      #https://www.postgresql.org/docs/current/datatype-net-types.html#DATATYPE-INET
      column :ip_address, :inet, null: false, index: { unique: true }
      column :enabled, :boolean, default: true, null: false
    end

    # add_index :ips, :ip_address, unique: true
  end
end
