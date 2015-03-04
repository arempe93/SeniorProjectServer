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

	## Functions

	## Class Functions
	def self.create_from_oauth(auth)
		User.create uid: auth['uid'], 
			name: auth['info']['name'], email: auth['info']['email'],
			api_token: auth['credentials']['token'],
			image: auth['info']['image'].split('?')[0]
	end
end