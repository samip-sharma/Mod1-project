
require 'rake'
require 'active_record'
require 'yaml/store'
require 'ostruct'
require 'date'

require 'bundler/setup'
Bundler.require


ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: "db/playlist.sqlite"
)

ActiveRecord::Base.logger = Logger.new(STDOUT)

require_all 'app'

require_all 'parsing_API'
