# == Schema Information
#
# Table name: books
#
#  id             :integer          not null, primary key
#  isbn_13        :string
#  isbn_10        :string
#  authors        :string
#  edition        :string
#  binding        :string
#  publisher      :string
#  published_date :string
#  price          :decimal(8, 2)
#  image          :string
#

class Book < ActiveRecord::Base

	## Callbacks

	## Validations

	## Relationships

	## Functions

	## Class Functions
end