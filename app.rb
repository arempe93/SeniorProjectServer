require 'sinatra'
require 'sinatra/activerecord'
require 'omniauth-google-oauth2'
require 'require_all'

require_relative 'config/environments'

require_all 'models'

get '/' do

	erb :home
end

get '/login/?' do

	unless session[:user]
		redirect to '/auth/google_oauth2'
	else
		redirect to '/welcome'
	end
end

get '/auth/:provider/callback/?' do

	auth = request.env['omniauth.auth'].to_hash

	session[:user] = nil
	session[:user] = User.find_by uid: auth['uid']

	session[:user] = User.create_from_oauth(auth) unless session[:user]

	redirect to '/welcome'
end

get '/welcome/?' do

	@user = User.find sessions['user']
	erb :auth
end