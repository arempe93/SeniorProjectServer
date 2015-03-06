# == Schema Information
#
# Table name: users
#
#  id        :integer          not null, primary key
#  email     :string           not null
#  name      :string           not null
#  api_token :string
#  uid       :string
#  image     :string
#

class User < ActiveRecord::Base

	## Callback

	## Validations

	## Relationships
	has_many :wanted_books
	has_many :desired_books, through: :wanted_books, source: :book

	has_many :owned_books
	has_many :possessed_books, through: :owned_books, source: :book

	## Functions

	## Class Functions
	def self.create_from_oauth(auth)

		# Don't allow non-McDaniel emails
		return nil unless auth['info']['email'].end_with? 'mcdaniel.edu'

		User.create uid: auth['uid'], 
			name: auth['info']['name'], email: auth['info']['email'],
			api_token: auth['credentials']['token'],
			image: auth['info']['image'].split('?')[0]
	end
end