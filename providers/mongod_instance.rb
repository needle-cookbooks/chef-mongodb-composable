include ::Opscode::MongoDB::ProviderHelpers

def load_current_resource
  new_resource.state
  @run_context.include_recipe 'runit'
end

action :enable do

  executable = ::File.join(new_resource.install_prefix, 'bin/mongod')
  options = new_resource.state

  create_user_and_group(new_resource.user, new_resource.group)

  directory ::File.join(new_resource.install_prefix, 'config') do
    owner new_resource.user
    group new_resource.group
    recursive true
    mode 00755
  end

  directory new_resource.logpath do
    owner new_resource.user
    group new_resource.group
    recursive true
    mode 00755
  end

  directory new_resource.dbpath do
    owner new_resource.user
    group new_resource.group
    recursive true
    mode 00755
  end

  config_file = ::File.join(new_resource.install_prefix, 'config', "#{new_resource.name}.conf")

  template config_file do
    action :create
    cookbook 'mongodb'
    source 'mongod.conf.erb'
    owner new_resource.user
    group new_resource.group
    mode 00644
    variables(
      :name => new_resource.name,
      :executable => executable,
      :options => options
    )
  end

  runit_service new_resource.name do
    run_template_name 'mongod'
    log_template_name 'mongod'
    cookbook 'mongodb'
    subscribes :restart, "template[#{config_file}]"
    options(
      'user' => new_resource.user,
      'install_prefix' => new_resource.install_prefix,
      'config_file' => config_file
    )
  end

  new_resource.updated_by_last_action(true)
end

action :disable do
  runit_service new_resource.name do
    action :disable
  end
  new_resource.updated_by_last_action(true)
end
