require 'sinatra/activerecord/rake'
require 'rake'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do
end

namespace :db do
  task :load_config do
    require "./app"
  end
end

task :default => :spec
