# mongodb cookbook

This cookbook provides opinionated LWRPs for installing and configuring 10gen's MongoDB database, supervised by `runit`.

# Requirements

Linux

# Usage

The cookbook defines the following resources:

`mongodb_release`

Downloads and unpacks a MongoDB binary release tarball [as provided by 10gen](http://docs.mongodb.org/manual/tutorial/install-mongodb-on-linux/).

This resource requires a `version` parameter, and by default will unpack the release to `/opt/mongodb/$VERSION`.

`mongodb_mongod_instance`

Configures, starts and enables an instance of the `mongod` daemon as a service. Requires an `install_prefix` parameter.

# Attributes

There are none

# Recipes

They do nothing

# TODO

Add LWRPs for `mongodb_mongos_instance` and `mongodb_configsvr_instance`

# Author

Author:: Needle Ops (<ops@needle.com>)
