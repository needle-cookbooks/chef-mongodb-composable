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
        @bind_ip = nil
        @port = 27017
        @logpath = '/var/log/mongodb'
        @dbpath = '/data/db'
        @configdb = nil
        @rest = false
        @prealloc = true
        @journal = true
        @smallfiles = false
        @replicaset = nil
        @shard = nil
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

      def bind_ip(arg=nil)
        set_or_return(:bind_ip, arg, :kind_of => [String])
      end

      def port(arg=nil)
        set_or_return(:port, arg, :kind_of => [Fixnum])
      end

      def logpath(arg=nil)
        set_or_return(:logpath, arg, :kind_of => [String])
      end

      def dbpath(arg=nil)
        set_or_return(:dbpath, arg, :kind_of => [String])
      end

      def configdb(arg=nil)
        set_or_return(:configdb, arg, :kind_of => [String, NilClass])
      end

      def rest(arg=nil)
        set_or_return(:rest, arg, :kind_of => [TrueClass, FalseClass])
      end

      def prealloc(arg=nil)
        set_or_return(:prealloc, arg, :kind_of => [TrueClass, FalseClass])
      end

      def journal(arg=nil)
        set_or_return(:journal, arg, :kind_of => [TrueClass, FalseClass])
      end

      def smallfiles(arg=nil)
        set_or_return(:smallfiles, arg, :kind_of => [TrueClass, FalseClass])
      end

      def replicaset(arg=nil)
        set_or_return(:replicaset, arg, :kind_of => [String, NilClass])
      end

      def shard(arg=nil)
        set_or_return(:shard, arg, :kind_of => [String, NilClass])
      end
    end
  end
end
