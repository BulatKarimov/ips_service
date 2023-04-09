module IpsService
  module Repos
    class IpRepo
      include Deps['database.rom']

      def relation
        @relation ||= rom.relations[:ips]
      end

      def find(primary_key)
        relation.by_pk(primary_key).one
      end

      def enable(primary_key)
        relation.by_pk(primary_key).changeset(:update, enabled: true).commit
      end

      def disable(primary_key)
        relation.by_pk(primary_key).changeset(:update, enabled: false).commit
      end

      def create(ip_address:, enabled:)
        attributes = { ip_address: ip_address, enabled: enabled }.compact

        relation.changeset(:create, attributes).commit
      end

      def destroy(primary_key)
        relation.by_pk(primary_key).changeset(:delete).commit
      end
    end
  end
end