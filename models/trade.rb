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

	belongs_to :counter_offer, class_name: 'Trade'

	## Functions
	def as_json(options = {})
		super.merge({

			counter_offer: counter_offer.as_json
		})
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
end
