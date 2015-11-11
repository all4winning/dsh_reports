class AddWordpressIdToFacebookPost < ActiveRecord::Migration
  def change
  	add_column :facebook_posts, :wordpress_id, :string
  end
end
