require 'sinatra'
require 'sinatra/activerecord'
require 'omniauth-google-oauth2'
require 'require_all'

require_relative 'config/environments'

require_all 'mailers'
require_all 'models'

get '/' do

	erb :home
end

get '/confirm/?' do
	
	if User.confirm params[:token]
		redirect to('/confirm/success') 
	
	else redirect to('/confirm/error')
	end
end

get '/testcallback/?'

	@auth = request.env

	erb :auth
end

get '/confirm/error/?' do

	erb :'confirmations/error'
end

get '/confirm/success/?' do

	erb :'confirmations/success'
end