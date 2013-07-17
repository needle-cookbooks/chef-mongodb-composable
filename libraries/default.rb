module Opscode
  module MongoDB
    module ProviderHelpers

      private

      def create_user_and_group(username, groupname)
        group groupname

        user username do
          gid groupname
        end
      end

    end
  end
end
