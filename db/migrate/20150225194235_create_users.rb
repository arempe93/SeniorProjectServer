class CreateUsers < ActiveRecord::Migration
	def change
		create_table :users do |t|
			
			## Basic information
			t.string :email,		null: false
			t.string :name,			null: false

			## Authentication
			t.string :password,		null: false
			t.string :api_token

			## Confirmation
			t.string :confirmation_token
			t.datetime :confirmed_at
			t.datetime :confirmation_sent_at
		end

		add_index :users, :email,	unique: true
	end
end