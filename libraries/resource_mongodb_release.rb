# encoding: utf-8

class Chef
  class Resource
    class MongodbRelease < Chef::Resource

      def initialize(name, run_context=nil)
        super
        @resource_name = :mongodb_release
        @provider = Chef::Provider::MongodbRelease
        @action = :install
        @allowed_actions = [:install, :symlink]

        @name = name
        @url = nil
        @checksum = nil
        @download_prefix = Chef::Config[:file_cache_path]
        @install_prefix = '/opt/mongodb'
        @symlink_prefix = '/usr/local/bin'
        @user = 'mongodb'
        @group = 'mongodb'
      end

      def url(arg=nil)
        set_or_return(:url, arg, :kind_of => [String])
      end

      def checksum(arg=nil)
        set_or_return(:checksum, arg, :kind_of => [String,NilClass])
      end

      def download_prefix(arg=nil)
        set_or_return(:download_prefix, arg, :kind_of => [String])
      end

      def install_prefix(arg=nil)
        set_or_return(:install_prefix, arg, :kind_of => [String])
      end

      def symlink_prefix(arg=nil)
        set_or_return(:symlink_prefix, arg, :kind_of => [String])
      end

      def user(arg=nil)
        set_or_return(:user, arg, :regex => [Chef::Config[:user_valid_regex]])
      end

      def group(arg=nil)
        set_or_return(:group, arg, :regex => [Chef::Config[:group_valid_regex]])
      end

    end
  end
end
