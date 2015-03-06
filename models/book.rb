# == Schema Information
#
# Table name: books
#
#  id        :integer          not null, primary key
#  isbn_13   :string
#  isbn_10   :string
#  authors   :string
#  edition   :string
#  binding   :string
#  publisher :string
#  price     :decimal(8, 2)
#  image     :string
#  title     :string
#  published :string
#

class Book < ActiveRecord::Base

	## Callbacks

	## Validations

	## Relationships
	has_many :wanted_books
	has_many :desirers, through: :wanted_books, source: :user

	has_many :owned_books
	has_many :owners, through: :owned_books, source: :user

	## Functions

	## Class Functions
end
