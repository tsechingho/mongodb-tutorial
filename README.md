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

## Master Slave

Create database repositories

    mkdir -p /usr/local/var/mongodb_master
    mkdir -p /usr/local/var/mongodb_slave1
    mkdir -p /usr/local/var/mongodb_slave2
    ls -alh /usr/local/var/mongodb_master /usr/local/var/mongodb_slave*

Start servers

    mongod run --config config/mongod.master.conf &
    mongod run --config config/mongod.slave1.conf &
    mongod run --config config/mongod.slave2.conf &
    ps aux | grep mongod

Open mongo consoles in different shells

    mongo localhost:27018
    mongo localhost:27019
    mongo localhost:27020

Open web ui

    open http://localhost:28018
    open http://localhost:28019
    open http://localhost:28020

Run demo scripts

    bin/master_slave.rb

Failover to slave1

  * shut down master
  * stop mongod on slave1, slave2
  * backup or delete local.* datafiles on slave1
  * restart mongod on slave1 with the --master option
  * restart mongod on slave2 with new --source option

Use relica set to simulate master-slave to avoid complicated failover manipulation. Just change configurations

    mongo localhost:27018
    > config = {
      _id: 'demoMasterSlaveByReplicaSet',
      members: [
        { _id: 0, host: 'localhost:27018', priority: 1 },
        { _id: 1, host: 'localhost:27019', priority: 0, votes: 0 },
        { _id: 2, host: 'localhost:27020', priority: 0, votes: 0 } ]
      }
    > rs.initiate(config)

