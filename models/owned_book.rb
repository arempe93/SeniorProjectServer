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
end