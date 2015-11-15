class AddPaymentFieldsToUser < ActiveRecord::Migration
  def change
  	add_column :users, :base_page_views_per_list, :integer
  	add_column :users, :price_per_list, :integer
  	add_column :users, :price_per_news, :integer
  	add_column :users, :above_base_price, :integer
  	add_column :users, :bellow_base_price, :integer
  end
end
