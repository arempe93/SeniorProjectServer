configure :development, :production do
	
	# Database connection
	db = YAML.load(ERB.new(File.read(File.join("config","database.yml"))).result)
	ActiveRecord::Base.establish_connection(db[settings.environment.to_s])

	# Omniauth
	enable :sessions

	use Rack::Session::Cookie
	use OmniAuth::Builder do
		provider :google_oauth2, ENV['GOOGLE_PROJECT_ID'], ENV['GOOGLE_PROJECT_SECRET']
	end
end