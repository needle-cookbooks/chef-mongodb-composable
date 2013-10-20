class Chef
  class Resource
    class MongodInstance < Chef::Resource

      def initialize(name, run_context=nil)
        super
        @resource_name = :mongod_instance
        @provider = Chef::Provider::MongodInstance
        @action = :enable
        @allowed_actions = [:enable, :disable]

        @user = 'mongodb'
        @group = 'mongodb'
        @install_prefix = '/opt/mongodb'
        @config_template = 'mongod.conf.erb'
        @config_cookbook = nil
        @logpath = '/var/log/mongodb'
        @dbpath = '/data/db'
        @options = {
          bind_ip: nil,
          port: 27017,
          configdb: nil,
          rest: false,
          prealloc: true,
          journal: true,
          smallfiles: false,
          replicaset: nil,
          shard: nil
        }
      end

      def user(arg=nil)
        set_or_return(:user, arg, :regex => [Chef::Config[:user_valid_regex]])
      end

      def group(arg=nil)
        set_or_return(:group, arg, :regex => [Chef::Config[:group_valid_regex]])
      end

      def install_prefix(arg=nil)
        set_or_return(:install_prefix, arg, :kind_of => [String])
      end

      def dbpath(arg=nil)
        set_or_return(:dbpath, arg, :kind_of => [String])
      end

      def logpath(arg=nil)
        set_or_return(:logpath, arg, :kind_of => [String])
      end

      def config_template(arg=nil)
        set_or_return(:config_template, arg, :kind_of => [String])
      end

      def config_cookbook(arg=nil)
        set_or_return(:config_cookbook, arg, :kind_of => [String])
      end

      def options(arg=nil)
        set_or_return(:options, arg, :kind_of => [Hash])
      end
    end
  end
end
