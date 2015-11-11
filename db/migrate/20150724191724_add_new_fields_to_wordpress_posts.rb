class AddNewFieldsToWordpressPosts < ActiveRecord::Migration
  def change
    add_column :wordpress_posts, :page_views_per_user, :float, default: 0
    add_column :users, :active, :boolean, default: true
  end
end
