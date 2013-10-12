#!/usr/bin/env bats

@test "downloaded and unpacked mongodb release" {
  exe="/opt/mongodb/2.4.5/bin/mongod"
  [ -f $exe ] && [ -x $exe ]
}

@test "symlinked mongod binary into /usr/local/bin" {
  [ -s /usr/local/bin/mongod ]
}

@test "started mongodb" {
  # should return a 0 status code if mongodb is running
  run /etc/init.d/mongodb status
  [ $status -eq 0 ]
}

@test "mongodb listens on port 37017" {
  run nc -z 0.0.0.0 37017
  [ $status -eq 0 ]
}

@test "mongodb data is being written to /opt/mongodb/data/db" {
  [ -f /opt/mongodb/data/mongod.lock ] && [ -f /opt/mongodb/data/local.ns ]
}

@test "journaling is enabled" {
  [ -d /opt/mongodb/data/journal ]
}
