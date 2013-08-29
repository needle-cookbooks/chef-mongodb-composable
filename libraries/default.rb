require 'chef/provider/user'
require 'chef/resource/user'
require 'chef/provider/group'
require 'chef/resource/group'

module Opscode
  module MongoDB
    module ProviderHelpers

      private

      def create_user_and_group(username, groupname)
        new_group = Chef::Resource::Group.new(groupname, run_context)

        new_user = Chef::Resource::User.new(username, run_context)
        new_user.gid(groupname)

        new_group.run_action(:create)
        new_user.run_action(:create)
      end

    end
  end
end
