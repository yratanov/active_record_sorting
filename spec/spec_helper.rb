require 'active_record_sorting'
require 'active_record'

ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'

require 'fixtures/schema'
require 'fixtures/group'
require 'fixtures/user'
