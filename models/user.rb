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

	has_many :sent_trades, class_name: 'Trade', foreign_key: 'sender_id'
	has_many :received_trades, class_name: 'Trade', foreign_key: 'receiver_id'

	## Functions
	def trades
		result = User.connection.execute("select * from trades t where (sender_id = #{id} or receiver_id = #{id}) and not exists (select 1 from trades n where n.counter_offer_id = t.id);")
		trades = result.map { |row| Trade.instantiate(row) }
	end

	def top_level_trades

	end

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