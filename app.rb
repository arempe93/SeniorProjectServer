require 'sinatra'
require 'sinatra/activerecord'
require 'require_all'

require_relative 'config/environments'

require_all 'mailers'
require_all 'models'

get '/confirm/?' do
	
	if User.confirm params[:token]
		redirect to('/confirm/success') 
	
	else redirect to('/confirm/error')
	end
end


get '/confirm/error/?' do

	error = "<%= 'ERROR' %>"
	erb error
end

get '/confirm/success/?' do

	success = "<%= 'SUCCESS' %>"
	erb success
end