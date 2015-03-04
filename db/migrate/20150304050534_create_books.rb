class CreateBooks < ActiveRecord::Migration
	def change
		create_table :books do |t|
			
			t.string :isbn_13
			t.string :isbn_10
			t.string :authors
			t.string :edition
			t.string :binding
			t.string :publisher
			t.string :published_date
			t.decimal :price,	precision: 8, scale: 2
			t.string :image
		end
	end
end