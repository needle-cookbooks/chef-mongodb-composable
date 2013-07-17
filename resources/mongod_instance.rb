def initialize(*args)
  super
  @action = :create
end

actions :create, :enable, :destroy

attribute :name, :kind_of => String, :name_attribute => true
attribute :user, :kind_of => String, :default => "mongodb"
attribute :group, :kind_of => String, :default => "mongodb"
attribute :init_style, :kind_of => String, :equal_to => ["init"], :default => "init"
attribute :install_prefix, :kind_of => String, :required => true
attribute :bind_ip, :kind_of => [String,NilClass], :default => nil
attribute :port, :kind_of => Fixnum, :default => 27017
attribute :logpath, :kind_of => String, :default => "/var/log/mongodb"
attribute :dbpath, :kind_of => String, :default => "/data/db/"
attribute :configdb, :kind_of => [Array, NilClass], :default => nil
attribute :rest, :kind_of => [TrueClass, FalseClass], :default => false
attribute :prealloc, :kind_of => [TrueClass, FalseClass], :default => true
attribute :journal, :kind_of => [TrueClass, FalseClass], :default => true
attribute :smallfiles, :kind_of => [TrueClass, FalseClass], :default => false
attribute :replicaset, :kind_of => [String, NilClass], :default => nil
attribute :shard, :kind_of => [String, NilClass], :default => nil

state_attrs(
  :bind_ip,
  :port,
  :logpath,
  :dbpath,
  :configdb,
  :rest,
  :prealloc,
  :journal,
  :replicaset,
  :shard
)
