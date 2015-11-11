class ChangeFieldsType < ActiveRecord::Migration
  def change
    change_column :facebook_posts, :picture_link, :text
    change_column :facebook_posts, :link, :text
    change_column :facebook_posts, :name, :text
    change_column :wordpress_posts, :title, :text
    change_column :wordpress_posts, :name, :text
  end
end
