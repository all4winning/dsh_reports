class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.string :facebook_email, null: false, default: ""
      t.string :first_name
      t.string :last_name
      t.string :profile_image_url
      t.text :access_token
      t.string :provider
      t.string :uid
      t.datetime :access_token_expires_at

      t.timestamps null: false
    end

    add_index :users, :facebook_email,                unique: true
  end
end
