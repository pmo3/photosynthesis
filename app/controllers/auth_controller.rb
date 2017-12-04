class AuthController < ApplicationController
  get '/login' do
    erb :"auth/login"
  end

  post '/unauthenticated' do
    session[:return_to] = env['warden.options'][:attempted_path] if session[:return_to].nil?
    # Set the error and use a fallback if the message is not defined
    flash[:error] = env['warden.options'][:message] || "You must log in"
    redirect '/auth/login'
  end

  get '/logout' do
    request.env['warden'].raw_session.inspect
    request.env['warden'].logout
    flash[:success] = "Successfully logged out"
    redirect '/'
  end

  post '/login' do
    request.env['warden'].authenticate!
    flash[:success] = "Successfully logged in"

    if session[:return_to].nil?
      redirect '/'
    else
      redirect session[:return_to]
    end
  end
end
