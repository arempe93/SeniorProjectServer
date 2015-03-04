class AddOmniauthInfoToUsers < ActiveRecord::Migration
	def change
		add_column :users, :uid, :string
		add_column :users, :image, :string

		remove_column :users, :password
	end
end