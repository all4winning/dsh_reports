class CreateWordpressPosts < ActiveRecord::Migration
  def change
    create_table :wordpress_posts do |t|
      t.integer :wordpress_id
      t.string :title
      t.string :name
      t.datetime :created_time
      t.integer :wordpress_user_id
    end
  end
end
