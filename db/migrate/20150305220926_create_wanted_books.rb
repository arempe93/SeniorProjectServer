class CreateWantedBooks < ActiveRecord::Migration
	def change
		create_table :wanted_books do |t|

			t.references :book
			t.references :user
		end
	end
end