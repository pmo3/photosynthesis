require 'bundler'
Bundler.require
Bundler.require(Sinatra::Base.environment)

require './app'

use Rack::Session::Cookie, secret: "IdoNotHaveAnySecret"
use Warden::Manager do |config|
  # serialize user to session ->
  config.serialize_into_session{|user| user.id}
  # serialize user from session <-
  config.serialize_from_session{|id| User.find(id) }
  # configuring strategies
  config.scope_defaults :default,
          strategies: [:password],
          action: 'auth/unauthenticated'
  config.failure_app = self
end

map('/') { run PagesController }
map('/auth') { run AuthController }
