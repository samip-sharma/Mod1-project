require_relative 'config/environment.rb'
require 'sinatra/activerecord/rake'

desc "Start our app console"
task :console do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  pry.start
end
