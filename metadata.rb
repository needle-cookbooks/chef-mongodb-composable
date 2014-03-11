name             'mongodb-composable'
maintainer       'Needle Ops'
maintainer_email 'cookbooks@needle.com'
license          'Apache 2.0'
description      'Installs/Configures mongodb'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.1'

depends 'runit'

%w{ ubuntu debian centos redhat fedora amazon scientific}.each do |os|
  supports os
end
