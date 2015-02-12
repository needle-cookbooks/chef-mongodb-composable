source "https://supermarket.chef.io"

metadata

# seems to be necessary to use newer runit cookbook
# for older centos platforms
cookbook 'runit', '~> 1.5.10'

group "integration" do
  cookbook 'mongodb-test', path: './test/cookbooks/mongodb-test'
  cookbook 'apt'
  cookbook 'yum'
end
