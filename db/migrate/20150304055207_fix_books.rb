class FixBooks < ActiveRecord::Migration
	def change
		add_column :books, :title, :string

		remove_column :books, :published_date
		add_column :books, :published, :string
	end
end