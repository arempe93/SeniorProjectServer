class CreateOwnedBooks < ActiveRecord::Migration
	def change
		create_table :owned_books do |t|

			t.references :book
			t.references :user
		end
	end
end