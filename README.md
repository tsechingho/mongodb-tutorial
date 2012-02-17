# Mongodb Tutorial

This tutorial only use one machine for demo purpose.

[mongoid](https://github.com/mongoid/mongoid) is used as ruby ODM framework of MongoDB.

## Replica Set

Create database repositories

    mkdir -p /usr/local/var/mongodb_replica1
    mkdir -p /usr/local/var/mongodb_replica2
    mkdir -p /usr/local/var/mongodb_replica3
    ls -alh /usr/local/var/mongodb_replica*

Start servers

    mongod run --config config/mongod.replica1.conf &
    mongod run --config config/mongod.replica2.conf &
    mongod run --config config/mongod.replica3.conf &
    ps aux | grep mongod

Initiate relica set

    mongo localhost:27021
    > rs.help()
    > config = {
      _id: 'demoReplicaSet',
      members: [
        { _id: 0, host: 'localhost:27021' },
        { _id: 1, host: 'localhost:27022' },
        { _id: 2, host: 'localhost:27023' } ]
      }
    > rs.initiate(config)
    > rs.status()

Open mongo consoles in different shells

    mongo localhost:27021
    mongo localhost:27022
    mongo localhost:27023

Open web ui

    open http://localhost:28021
    open http://localhost:28022
    open http://localhost:28023

Run demo scripts to populate data

    bin/replica_set.rb

Failover

    kill -9 [process_id of primary replica]

