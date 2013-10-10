# Notice

This cookbook is under active development, and its public interface may change.

What this warning means is that the attributes, and actions used by `mongod_instance`,
`mongodb_release` and other pieces of this cookbook may drastically change. 
When using this cookbook please reference an exact SHA commit from this repository to ensure continuous functionality.

# mongodb-composable cookbook

This cookbook provides opinionated resources and providers for installing and configuring 10gen's MongoDB database, supervised by `runit`.

# Requirements

Linux

# Usage

The cookbook defines the following resources:

`mongodb_release`

Downloads and unpacks a MongoDB binary release tarball [as provided by 10gen](http://docs.mongodb.org/manual/tutorial/install-mongodb-on-linux/).

This resource requires a `version` parameter, and by default will unpack the release to `/opt/mongodb/$VERSION`.

`mongod_instance`

Configures, starts and enables an instance of the `mongod` daemon as a service. Requires an `install_prefix` parameter.

# Attributes

There are none

# Recipes

They do nothing

# TODO

Add resources/providers for `mongodb_mongos_instance` and `mongodb_configsvr_instance`

# Author

Author:: Needle Ops (<ops@needle.com>)
