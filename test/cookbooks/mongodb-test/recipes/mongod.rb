#
# Cookbook Name:: mongodb_test
# Recipe:: default
#
# Copyright 2013, Needle, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'mongodb-composable::default'

# this will yield mongodb 2.4.5 binaries installed at /opt/mongodb/2.4.5/bin
mongodb_release "2.4.5" do
  url "http://downloads.mongodb.org/linux/mongodb-linux-x86_64-2.4.5.tgz"
  download_prefix '/opt/mongodb/cache'
  checksum '2f9791a33dda71f8ee8f40100f49944b9261ed51df1f62bdcbeef2d71973fcbf'
  action [:install, :symlink]
end

# this will configure and enable a mongod instance which uses the above release binaries
mongod_instance "mongodb" do
  install_prefix '/opt/mongodb/2.4.5'
  dbpath '/opt/mongodb/data'
  options({ port: 37017 })
  action :enable
end
