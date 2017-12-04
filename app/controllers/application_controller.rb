class ApplicationController < Sinatra::Base
  register Sinatra::Flash
  helpers ApplicationHelper
  set :views, File.expand_path('../../views', __FILE__)

  configure :production, :development do
    enable :logging
  end
end
