#
# Cookbook Name:: mongodb_test
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# this will yield mongodb 2.4.5 binaries installed at /opt/mongodb/2.4.5/bin
mongodb_release "i can put literally anything here" do
  version "2.4.5"
  action :install
  download_prefix '/opt/mongodb/cache'
  checksum '2f9791a33dda71f8ee8f40100f49944b9261ed51df1f62bdcbeef2d71973fcbf'
end

mongodb_configsvr_instance 'mongo-configsvr' do
  install_prefix '/opt/mongodb/2.4.5'
  action [:create, :enable]
end

mongodb_mongos_instance 'mongos' do
  install_prefix '/opt/mongodb/2.4.5'
  configdb ['localhost:27019']
  action [:create, :enable]
end
