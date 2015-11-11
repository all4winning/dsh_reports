class AddUsersToWordpressPosts < ActiveRecord::Migration
  def change
    add_column :wordpress_posts, :users, :integer, default: 0
  end
end
