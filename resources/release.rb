def initialize(*args)
  super
  @action = :install
end

actions :install

attribute :name, :kind_of => String, :name_attribute => true
attribute :version, :kind_of => String, :required => true
attribute :checksum, :kind_of => [String, NilClass], :default => nil
attribute :download_prefix, :kind_of => String, :default => Chef::Config[:file_cache_path]
attribute :install_prefix, :kind_of => String, :default => '/opt/mongodb'
attribute :user, :kind_of => String, :default => 'mongodb'
attribute :group, :kind_of => String, :default => 'mongodb'
