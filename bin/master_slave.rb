#!/usr/bin/env ruby

$LOAD_PATH.unshift 'lib'

require 'user'

ENV['RACK_ENV'] ||= 'master_slave'

Mongoid.load! 'config/mongoid.yml'
Mongoid.logger = Logger.new($stdout, :warn)

## Populate data
puts User.count
george = User.find_or_create_by name: 'George', age: 20
mary = User.find_or_create_by name: 'Mary', age: 18
User.all.each { |user| puts user.inspect }
puts User.count
