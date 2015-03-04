require 'sinatra'
require 'sinatra/activerecord'
require 'omniauth-google-oauth2'
require 'require_all'

require_relative 'config/environments'
require_relative 'lib/book_scraper'

require_all 'models'

###
#	User Authentication
###

get '/' do

	erb :home
end

get '/login/?' do

	unless session[:user]
		redirect to '/auth/google_oauth2'
	else
		redirect to '/userinfo'
	end
end

get '/auth/google_oauth2/callback/?' do

	# Get omniauth hash
	auth = request.env['omniauth.auth'].to_hash

	# Clear session and find user with return uid
	session[:user] = nil
	session[:user] = User.find_by uid: auth['uid']

	# If uid wasn't found, create a new user for it
	session[:user] = User.create_from_oauth(auth) unless session[:user]

	# If session is created, return user info. If it wasn't it's a non-mcdaniel email
	if session[:user]
		redirect to '/userinfo'
	else
		redirect to '/autherror'
	end
end

get '/userinfo/?' do
	content_type :json

	@user = User.find session[:user]
	@user.to_json
end

get '/autherror/?' do
	content_type :json

	{ error: 'Authentication Error', message: 'You cannot sign up without a McDaniel email address' }.to_json
end

###
#	Books
###

get '/books/find/:isbn' do

	book = nil
	isbn = params[:isbn]

	if isbn.length == 13
		book = Book.find_by isbn_13: isbn
	else
		book = Book.find_by isbn_10: isbn
	end

	book ? book.to_json : BookScraper.find_book(isbn).to_json
end