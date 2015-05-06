class CreateTrades < ActiveRecord::Migration
	def change
		create_table :trades do |t|
			
			t.references :sender
			t.references :receiver
			t.integer :sender_books,		array: true, default: []
			t.integer :receiver_books,		array: true, default: []
			t.decimal :sender_extras,		precision: 8, scale: 2, default: 0.0
			t.decimal :receiver_extras,		precision: 8, scale: 2, default: 0.0
			t.references :counter_offer
			t.boolean :accepted,			default: false
		end
	end
end