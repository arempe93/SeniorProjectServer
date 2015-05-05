# == Schema Information
#
# Table name: trades
#
#  id               :integer          not null, primary key
#  sender_id        :integer
#  receiver_id      :integer
#  sender_books     :integer          default("{}"), is an Array
#  receiver_books   :integer          default("{}"), is an Array
#  sender_extras    :decimal(8, 2)    default("0.0")
#  receiver_extras  :decimal(8, 2)    default("0.0")
#  counter_offer_id :integer
#  accepted         :boolean          default("false")
#

class Trade < ActiveRecord::Base

	## Callbacks

	## Validations

	## Relationships
	belongs_to :sender, class_name: 'User'
	belongs_to :receiver, class_name: 'User'

	belongs_to :counter_offer, class_name: 'Trade', dependent: :destroy

	## Functions
	def as_json(options = {})
		{
			id: id,
			sender: User.find(sender_id).as_json,
			sender_books: Book.find(sender_books).as_json,
			sender_extras: sender_extras,
			receiver: User.find(receiver_id).as_json,
			receiver_books: Book.find(receiver_books).as_json,
			receiver_extras: receiver_extras,
			accepted: accepted,
			counter_offer: counter_offer.as_json
		}
	end

	## Class Functions
	def self.past_trades_for(trade)

		trades = [trade]

		while not trade.counter_offer_id == nil

			trade = trade.counter_offer
			trades << trade
		end

		trades
	end

	def self.suggest_for_user(user)

		suggestions = []

		wanted_books = user.desired_books.map { |book| book.id }
		owned_books = user.possessed_books.map { |book| book.id }

		# Find users that have books for mutual trades

		User.wants_any(owned_books).delete_if { |user| not User.has_any(wanted_books).include?(user) }.each do |user|

			suggestions << {

				user: user,
				their_books: OwnedBook.where(book_id: wanted_books, user_id: user.id).map { |row| row.as_json },
				your_books: WantedBook.where(book_id: owned_books, user_id: user.id).map { |row| row.as_json }
			}
		end

		suggestions
	end
end
