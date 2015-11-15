class AddEarningsToWordpressPost < ActiveRecord::Migration
  def change
  	add_column :wordpress_posts, :earnings, :integer, default: 0
  end
end
