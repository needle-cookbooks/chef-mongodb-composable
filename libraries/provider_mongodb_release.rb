require 'chef/provider/directory'
require 'chef/resource/directory'
require 'chef/provider/template'
require 'chef/resource/template'
require 'chef/provider/file'
require 'chef/resource/file'
require 'chef/provider/user'
require 'chef/resource/user'
require 'chef/provider/group'
require 'chef/resource/group'

class Chef
  class Provider
    class MongodbRelease < Chef::Provider

      include ::Opscode::MongoDB::ProviderHelpers

      def initialize(*args)
        super
        @version = nil
        @checksum = nil
        @download_prefix = nil
        @install_prefix = nil
        @user = nil
        @group = nil
      end

      def load_current_resource
        @current_resource = Chef::Resource::MongodbRelease.new(new_resource.name, run_context)
        @current_resource.version(new_resource.version)
        @current_resource.install_prefix(new_resource.install_prefix)
        @current_resource
      end

      def versioned_path
        return ::File.join(@new_resource.install_prefix, @new_resource.version)
      end

      def action_install
        unless node['os'] == 'linux'
          Chef::Application.fatal "Sorry, I don't know how to install MongoDB on #{node['os']}"
        end

        cpu = case node['kernel']['machine']
        when /^(x86_|amd)64$/i
          'x86_64'
        when /^(x|i[3456])86$/i
          'i686'
        end

        tarball_name = "mongodb-linux-#{cpu}-#{@new_resource.version}.tgz"
        tarball_path = ::File.join(@new_resource.download_prefix, tarball_name)

        create_user_and_group(@new_resource.user, @new_resource.group)

        [@new_resource.download_prefix, versioned_path].each do |dir|
          dir_resource = Chef::Resource::Directory.new(dir, run_context)
          dir_resource.mode(0755)
          dir_resource.owner(@new_resource.user)
          dir_resource.group(@new_resource.group)
          dir_resource.recursive(true)
          dir_resource.run_action(:create)
        end

        unless @new_resource.checksum
          Chef::Log.warn("mongodb_release[#{@new_resource.version}] did not specify a checksum, chef will download the corresponding mongodb tarball on every run")
        end

        tarball = Chef::Resource::RemoteFile.new(tarball_path, run_context)
        tarball.source "http://downloads.mongodb.org/linux/#{tarball_name}"
        tarball.checksum(@new_resource.checksum) if @new_resource.checksum
        tarball.owner(@new_resource.user)
        tarball.group(@new_resource.group)
        tarball.run_action(:create)

        unpack_script = Chef::Resource::Execute.new("unpack #{tarball_path}", run_context)
        unpack_script.cwd(::File.join(@new_resource.install_prefix, @new_resource.version))
        unpack_script.command("tar --strip-components=1 -zxvf #{tarball_path}")
        unpack_script.user(@new_resource.user)
        unpack_script.group(@new_resource.group)
        unpack_script.subscribes(:run, "remote_file[#{tarball_path}]", :immediately)

        unless ::File.exists?(::File.join(versioned_path, 'bin', 'mongod'))
          unpack_script.run_action(:run)
        end

      end

      def action_symlink
        executables = ::Dir.glob(::File.join(versioned_path, 'bin', '*'))
        executables.each do |exe|
          link ::File.join(@new_resource.symlink_prefix, ::File.basename(exe)) do
            to exe
          end
          @new_resource.updated_by_last_action(true)
        end
      end

      def action_remove
        # not yet implemented
      end

    end
  end
end
