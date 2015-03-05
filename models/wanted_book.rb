# == Schema Information
#
# Table name: wanted_books
#
#  id      :integer          not null, primary key
#  book_id :integer
#  user_id :integer
#

class WantedBook < ActiveRecord::Base

	## Callbacks

	## Validations

	## Relationships
	belongs_to :user
	belongs_to :book

	## Functions

	## Class Functions
end