require 'chef/provider'

class Chef
  class Provider
    class MongodInstance < Chef::Provider

      include ::Opscode::MongoDB::ProviderHelpers

      def load_current_resource
        @new_resource.state
      end

      def action_enable
        executable = ::File.join(@new_resource.install_prefix, 'bin/mongod')
        config_dir_path = ::File.join(@new_resource.install_prefix, 'config')
        config_file_path = ::File.join(@new_resource.install_prefix, 'config', "#{@new_resource.name}.conf")

        create_user_and_group(@new_resource.user, @new_resource.group)

        [config_dir_path, @new_resource.logpath, @new_resource.dbpath].each do |dir_path|
          unless ::File.symlink?(dir_path)
            dir = Chef::Resource::Directory.new(dir_path, run_context)
            dir.owner(@new_resource.user)
            dir.group(@new_resource.group)
            dir.recursive(true)
            dir.mode(00755)
            dir.run_action(:create)
          end
        end

        service = Chef::Resource::RunitService.new(@new_resource.name, run_context)
        service.run_template_name('mongod')
        service.log_template_name('mongod')
        service.cookbook('mongodb-composable')
        service.subscribes(:restart, "template[#{config_file_path}]")
        service.options(
            'user' => @new_resource.user,
            'install_prefix' => @new_resource.install_prefix,
            'config_file' => config_file_path
          )

        config_file = Chef::Resource::Template.new(config_file_path, run_context)
        config_file.cookbook('mongodb-composable')
        config_file.source('mongod.conf.erb')
        config_file.owner(@new_resource.user)
        config_file.group(@new_resource.group)
        config_file.mode(00644)
        config_file.variables(
            :name => @new_resource.name,
            :executable => executable,
            :options => {
              :bind_ip => @new_resource.bind_ip,
              :port => @new_resource.port,
              :logpath => @new_resource.logpath,
              :dbpath => @new_resource.dbpath,
              :configdb => @new_resource.configdb,
              :rest => @new_resource.rest,
              :prealloc => @new_resource.prealloc,
              :smallfiles => @new_resource.smallfiles,
              :journal => @new_resource.journal,
              :replicaset => @new_resource.replicaset,
              :shard => @new_resource.shard,
            }
          )
        config_file.notifies(:restart, service)
        config_file.run_action(:create)

        service.run_action(:enable)
        service.run_action(:restart) if config_file.updated_by_last_action?
      end
    end
  end
end
