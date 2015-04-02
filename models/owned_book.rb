# == Schema Information
#
# Table name: owned_books
#
#  id      :integer          not null, primary key
#  book_id :integer
#  user_id :integer
#

class OwnedBook < ActiveRecord::Base

	## Callbacks

	## Validations

	## Relationships
	belongs_to :user
	belongs_to :book

	## Functions

	## Class Functions
	def self.all_for_array(arr)

		books = []

		for book_id in arr
			books << self.find(book_id)
		end

		books
	end

	def as_json(options = {})
		super( :include => :book )
	end
end