require 'sinatra'
require 'sinatra/activerecord'
require 'omniauth-google-oauth2'
require 'require_all'

require_relative 'config/environments'
require_relative 'lib/book_scraper'

require_all 'models'

###
#	Helpers
###

helpers do

	def protect_request(key)
		unless User.find_by(api_token: key)
			show_error 'Not Authorized', 'That API key is not registered'
		end
	end

	def show_error(title, message)
		redirect to "/error?title=#{CGI.escape title}&message=#{CGI.escape message}"
	end
end

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

	if session[:user]
		@user = User.find session[:user]
		@user.to_json
	else
		redirect to '/login'
	end
end

get '/users/:uid/?' do
	content_type :json

	user = User.find_by uid: params[:uid]

	if user
		user.to_json
	else
		show_error 'Not Found', 'There is no user with the specified UID'
	end
end

###
#	Books
###

get '/books/find/:isbn' do
	content_type :json

	# Ensure request is authenticated
	protect_request(params[:key])

	# Find the book
	book = nil
	isbn = params[:isbn]

	if isbn.length == 13
		book = Book.find_by isbn_13: isbn
	else
		book = Book.find_by isbn_10: isbn
	end

	# Create the book if it doesn't exist
	book = Book.create BookScraper.find_book(isbn) unless book

	# Return the book details
	book.to_json
end

get '/books/:id' do
	content_type :json

	book = Book.find_by id: params[:id]

	if book
		book.to_json
	else
		show_error 'Not Found', 'There is no book with that id'
	end
end

###
#	Errors
###

get '/error' do

	{ error: { title: params['title'], message: params[:message] } }.to_json
end