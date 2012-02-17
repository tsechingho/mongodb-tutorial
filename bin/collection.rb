#!/usr/bin/env ruby

$LOAD_PATH.unshift 'lib'

require 'post'

ENV['RACK_ENV'] ||= 'development'

Mongoid.load! 'config/mongoid.yml'
Mongoid.logger = Logger.new($stdout, :warn)

puts Post.all
puts Post.create(title: 'Ruby', content: 'Taiwan')
puts Post.create(title: 'NoSQL', content: 'Taiwan')
puts Post.all
