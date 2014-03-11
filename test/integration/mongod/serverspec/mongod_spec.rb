require 'spec_helper'

describe file('/opt/mongodb/2.4.5/bin/mongod') do
  it { should be_file }
  it { should be_executable }
end

describe file('/usr/local/bin/mongod') do
  it { should be_linked_to('/opt/mongodb/2.4.5/bin/mongod') }
end

describe service('mongod-instance1') do
  it { should be_running }
end

describe port(27017) do
  it { should be_listening }
end

%w{ mongod.lock local.ns }.each do |mongofile|
  describe file("/opt/mongodb/instance1/data/#{mongofile}") do
    it { should be_file }
  end
end

describe service('mongod-instance2') do
  it { should be_running }
end

describe port(37017) do
  it { should be_listening }
end

%w{ mongod.lock local.ns }.each do |mongofile|
  describe file("/opt/mongodb/instance2/data/#{mongofile}") do
    it { should be_file }
  end
end

describe file('/opt/mongodb/2.4.5/config/mongod-instance2.conf') do
  its(:content) { should match /^nojournal = true$/  }
  its(:content) { should match /^noprealloc = true$/ }
  its(:content) { should match /^smallfiles = true$/ }
end
