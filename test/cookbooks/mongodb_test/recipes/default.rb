#
# Cookbook Name:: mongodb_test
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'mongodb::default'

# this will yield mongodb 2.4.5 binaries installed at /opt/mongodb/2.4.5/bin
mongodb_release "i can put literally anything here" do
  version "2.4.5"
  action :install
  download_prefix '/opt/mongodb/cache'
  checksum '2f9791a33dda71f8ee8f40100f49944b9261ed51df1f62bdcbeef2d71973fcbf'
end

# this will configure and enable a mongod instance which uses the above release binaries
mongod_instance "mongodb" do
  install_prefix '/opt/mongodb/2.4.5'
  action :enable
end
