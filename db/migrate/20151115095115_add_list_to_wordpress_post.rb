class AddListToWordpressPost < ActiveRecord::Migration
  def change
  	add_column :wordpress_posts, :list, :boolean, default: false
  end
end
