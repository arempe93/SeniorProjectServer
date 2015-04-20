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
		user = User.find_by(api_token: key)

		user ? user : show_error('Not Authenticated', 'The API key is missing or invalid', 401)
	end

	def show_error(title, message, status)
		
		session[:error_title] = title
		session[:error_message] = message
		session[:error_status] = status

		redirect "/error"
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
		show_error('Not Authenticated', 'Non-McDaniel email addresses are forbidden', 401)
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

get '/users/:id/?' do
	content_type :json

	user = User.find_by id: params[:id]

	user ? user.to_json : show_error('Not Found', 'There is no user with the specified ID', 404)
end

###
#	Books
###

get '/books/find/:isbn' do
	content_type :json

	# Ensure request is authenticated
	protect_request params[:key]

	# Find the book
	book = nil
	isbn = params[:isbn]

	book = isbn.length == 13 ? Book.find_by(isbn_13: isbn) : Book.find_by(isbn_10: isbn)

	# Create the book if it doesn't exist
	book = Book.create BookScraper.find_book(isbn) unless book

	# Return the book details
	book.to_json
end

get '/books/:id' do
	content_type :json

	book = Book.find_by id: params[:id]

	book ? book.to_json : show_error('Not Found', 'There is no book with that id', 404)
end

###
#	Wanted Books
###

get '/users/:id/wanted_books' do
	content_type :json

	# Ensure this request is authenticated
	protect_request params[:key]

	# Get user and return wanted books
	user = User.find_by id: params[:id]
	user ? user.wanted_books.to_json : show_error('Not Found', 'There is no user with that id', 404)
end

post '/users/:id/wanted_books' do
	content_type :json

	# Ensure this request is authenticated
	user = protect_request params[:key]

	# Ensure user making the request is the same as the user adding the book
	user = nil if User.find_by(id: params[:id]) != user

	user ? WantedBook.create(user_id: user.id, book_id: params[:book]) : show_error('Not Authenticated', 'The API key is missing or invalid or does not match the affected user', 401)
end

get '/books/:id/desirers/?' do
	content_type :json

	# Ensure this request is authenticated
	protect_request params[:key]

	book = Book.find_by id: params[:id]

	book ? book.desirers.to_json : show_error('Not Found', 'There is no book with that id', 404)
end

###
#	Owned Books
###

get '/users/:id/owned_books' do
	content_type :json

	# Ensure this request is authenticated
	protect_request params[:key]

	# Get user and return wanted books
	user = User.find_by id: params[:id]

	user ? user.owned_books.to_json : show_error('Not Found', 'There is no user with that id', 404)
end

post '/users/:id/owned_books' do
	content_type :json

	# Ensure this request is authenticated
	user = protect_request params[:key]

	# Ensure user making the request is the same as the user adding the book
	user = nil if User.find_by(id: params[:id]) != user

	user ? OwnedBook.create(user_id: user.id, book_id: params[:book]) : show_error('Not Authenticated', 'The API key is missing or invalid or does not match the affected user', 401)
end

delete '/owned_books/:id/?' do
	content_type :json

	# Ensure this request is authenticated
	user = protect_request params[:key]

	# Find book record
	book = OwnedBook.find_by id: params[:id]

	# Ensure user making the request is the same as the user deleting the book
	user = nil if book.user != user

	user ? book.destroy! : show_error('Not Authenticated', 'The API key is missing or invalid or does not match the affected user', 401)
end

get '/books/:id/owners/?' do
	content_type :json

	# Ensure this request is authenticated
	protect_request params[:key]

	book = Book.find_by id: params[:id]

	book ? book.owners.to_json : show_error('Not Found', 'There is no book with that id', 404)
end

###
#	Trades
###

get '/users/:id/trades/?' do
	content_type :json

	# Ensure this request is authenticated
	protect_request params[:key]

	# Find user
	user = User.find_by id: params[:id]

	user ? user.trades.to_json : show_error('Not Found', 'There is no user with that id', 404)
end

get '/users/:id/trades/suggest/?' do
	content_type :json

	# Ensure this request is authenticated
	protect_request params[:key]

	# Find user
	user = User.find_by id: params[:id]

	user ? Trade.suggest_for_user(user).to_json : show_error('Not Found', 'There is no user with that id', 404)
end

###
#	Errors
###

get '/error' do
	content_type :json

	status session[:error_status]

	{ error: { title: session[:error_title], message: session[:error_message] } }.to_json
end