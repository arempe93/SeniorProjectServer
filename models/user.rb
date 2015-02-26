# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  email                :string           not null
#  name                 :string           not null
#  password             :string           not null
#  api_token            :string
#  confirmation_token   :string
#  confirmed_at         :datetime
#  confirmation_sent_at :datetime
#

class User < ActiveRecord::Base

	## Callback
	after_create :generate_tokens
	after_create :send_confirmation

	## Validations
	validates :email, presence: { message: 'An account with this email already exists' }, uniqueness: { message: 'Please enter an email address' }
	validates :name, presence: { message: 'Please enter your name' }
	validates :password, presence: { message: 'Please enter a password' }

	## Relationships

	## Functions

	## Callback Functions
	def generate_tokens

		char_set = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map { |i| i.to_a }.flatten

		self.api_token = (0...30).map { char_set[rand(char_set.length)] }.join
		self.confirmation_token = (0...30).map { char_set[rand(char_set.length)] }.join
		self.confirmation_sent_at = DateTime.now
	end

	def send_confirmation
		UserConfirmationMailer.send_confirmation_email(self)
	end

	## Class Functions
	def self.confirm(token)

		user = User.find_by confirmation_token: token

		# if there is no user with the token, return false
		return false unless user

		# confirm user and return success of saving
		user.confirmed_at = DateTime.now
		return user.save
	end
end
