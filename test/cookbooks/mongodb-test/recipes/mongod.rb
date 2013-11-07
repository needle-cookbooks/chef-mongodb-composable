#
# Cookbook Name:: mongodb_test
# Recipe:: mongod
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

# this will yield mongodb binaries installed at "/opt/mongodb/#{node['mongodb_test']['version']}/bin"
mongodb_release node['mongodb_test']['version'] do
  url node['mongodb_test']['tarball_url']
  download_prefix node['mongodb_test']['download_prefix']
  checksum node['mongodb_test']['tarball_checksum']
  action [:install, :symlink]
end

# this will configure and enable a mongod instance which uses the above release binaries
mongod_instance "mongod-instance1" do
  install_prefix "/opt/mongodb/#{node['mongodb_test']['version']}"
  dbpath '/opt/mongodb/instance1/data'
  action :enable
end

mongod_instance "mongod-instance2" do
  install_prefix "/opt/mongodb/#{node['mongodb_test']['version']}"
  dbpath '/opt/mongodb/instance2/data'
  options({
    port: 37017,
    journal: false,
    prealloc: false,
    smallfiles: true
  })
  action :enable
end
