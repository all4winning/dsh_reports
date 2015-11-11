class AddAdminToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.boolean :admin, default: false
      t.string :wordpress_user_id
    end
  end
end
