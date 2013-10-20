#!/usr/bin/env bats

@test "downloaded and unpacked mongodb release" {
  exe="/opt/mongodb/2.4.5/bin/mongod"
  [ -f $exe ] && [ -x $exe ]
}

@test "symlinked mongod binary into /usr/local/bin" {
  [ -s /usr/local/bin/mongod ]
}

@test "started mongod instance 1" {
  # should return a 0 status code if mongodb is running
  run /etc/init.d/mongod-instance1 status
  [ $status -eq 0 ]
}

@test "mongod instance 1 listens on port 27017" {
  run nc -z 0.0.0.0 27017
  [ $status -eq 0 ]
}

@test "mongod instance 1 data is being written to /opt/mongodb/instance1/data/db" {
  [ -f /opt/mongodb/instance1/data/mongod.lock ] && [ -f /opt/mongodb/instance1/data/local.ns ]
}

@test "started mongod instance 2" {
  # should return a 0 status code if mongodb is running
  run /etc/init.d/mongod-instance2 status
  [ $status -eq 0 ]
}

@test "mongod instance 2 listens on port 37017" {
  run nc -z 0.0.0.0 37017
  [ $status -eq 0 ]
}

@test "mongod instance 2 data is being written to /opt/mongodb/instance2/data/db" {
  [ -f /opt/mongodb/instance2/data/mongod.lock ] && [ -f /opt/mongodb/instance2/data/local.ns ]
}

@test "mongod instance 2 journaling disabled" {
  run cat /opt/mongodb/2.4.5/config/mongod-instance2.conf
  [ $(expr "$output" : ".*nojournal = true.*") -ne 0 ]
}

@test "mongod instance 2 prealloc disabled" {
  run cat /opt/mongodb/2.4.5/config/mongod-instance2.conf
  [ $(expr "$output" : ".*noprealloc = true.*") -ne 0 ]
}

@test "mongod instance 2 smallfiles enabled" {
  run cat /opt/mongodb/2.4.5/config/mongod-instance2.conf
  [ $(expr "$output" : ".*smallfiles = true.*") -ne 0 ]
}
