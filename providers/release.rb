include ::Opscode::MongoDB::ProviderHelpers

action :install do

  unless node['os'] == 'linux'
    Chef::Application.fatal "Sorry, I don't know how to install MongoDB on #{node['os']}"
  end

  cpu = case node['kernel']['machine']
  when /^(x86_|amd)64$/i
    'x86_64'
  when /^(x|i[3456])86$/i
    'i686'
  end

  tarball_name = "mongodb-linux-#{cpu}-#{new_resource.version}.tgz"
  tarball_path = ::File.join(new_resource.download_prefix, tarball_name)
  versioned_path = ::File.join(new_resource.install_prefix, new_resource.version)

  create_user_and_group(new_resource.user, new_resource.group)

  [new_resource.download_prefix, versioned_path].each do |dir|
    directory dir do
      mode 00755
      owner new_resource.user
      group new_resource.group
      recursive true
    end
  end

  unless new_resource.checksum
    Chef::Log.warn("mongodb_release[#{new_resource.version}] did not specify a checksum, chef will download the corresponding mongodb tarball on every run")
  end

  remote_file tarball_path do
    source "http://downloads.mongodb.org/linux/#{tarball_name}"
    checksum new_resource.checksum if new_resource.checksum
    owner new_resource.user
    group new_resource.group
  end

  execute "unpack #{tarball_path}" do
    cwd ::File.join(new_resource.install_prefix, new_resource.version)
    command "tar --strip-components=1 -zxvf #{tarball_path}"
    user new_resource.user
    group new_resource.group
    action :nothing
    subscribes :run, "remote_file[#{tarball_path}]", :immediately
    not_if {::File.exists?(::File.join(versioned_path, 'bin', 'mongod'))}
  end
end
