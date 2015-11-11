class AddFieldsToWordpressPosts < ActiveRecord::Migration
  def change
    add_column :wordpress_posts, :sessions, :integer, default: 0
    add_column :wordpress_posts, :page_views, :integer, default: 0
    add_column :wordpress_posts, :unique_page_views, :integer, default: 0
    add_column :wordpress_posts, :page_views_per_session, :float, default: 0
    add_column :wordpress_posts, :average_time_on_page, :integer, default: 0
  end
end
