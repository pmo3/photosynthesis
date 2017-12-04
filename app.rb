require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/config_file'
require 'sinatra/content_for'
require 'sinatra/flash'
require 'sinatra/reloader'
require 'warden'

module Photosynthesis
  class App < Sinatra::Base
    enable :sessions

    configure do
      if ENV['DATABASE_URL'].blank?
        db_config = YAML.load(File.read('config/database.yml'))
        ActiveRecord::Base.establish_connection db_config['development']
      else
        ActiveRecord::Base.establish_connection ENV['DATABASE_URL']
      end

      Dir["./app/models/*.rb"].each { |file| require file }
      Dir["./app/helpers/*.rb"].each { |file| require file }
      Dir["./app/controllers/*.rb"].each { |file| require file }
      Dir["./app/lib/*.rb"].each { |file| require file }

      $stdout.sync = true

    end

    Warden::Strategies.add(:password) do

     def authenticate!
       user = User.where(username: params['username']).first
       if user.nil?
         fail!("Invalid username, doesn't exists!")
       elsif user.authenticate(params['password'])
         success!(user)
       else
         fail!("There are errors, please try again")
       end
     end
    end

    Warden::Manager.before_failure do |env,opts|
      # Because authentication failure can happen on any request but
      # we handle it only under "post '/auth/unauthenticated'", we need
      # to change request to POST
      env['REQUEST_METHOD'] = 'POST'
      # And we need to do the following to work with  Rack::MethodOverride
      env.each do |key, value|
        env[key]['_method'] = 'post' if key == 'rack.request.form_hash'
      end
    end
  end
end
