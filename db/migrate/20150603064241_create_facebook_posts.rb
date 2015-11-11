class CreateFacebookPosts < ActiveRecord::Migration
  def change
    create_table :facebook_posts do |t|
      t.string :facebook_id
      t.string :picture_link
      t.string :link
      t.string :name
      t.datetime :created_time
      t.string :facebook_user_id
      t.integer :impressions, default: 0
      t.integer :impressions_unique, default: 0
      t.integer :impressions_paid_unique, default: 0
      t.integer :impressions_paid, default: 0
      t.integer :impressions_organic_unique, default: 0
      t.integer :impressions_organic, default: 0
      t.integer :impressions_viral_unique, default: 0
      t.integer :impressions_viral, default: 0
      t.integer :impressions_fan_unique, default: 0
      t.integer :impressions_fan, default: 0
      t.integer :impressions_fan_paid_unique, default: 0
      t.integer :impressions_fan_paid, default: 0
      t.integer :consumptions, default: 0
      t.integer :consumptions_unique, default: 0
      t.integer :negative_feedback, default: 0
      t.integer :negative_feedback_unique, default: 0
      t.integer :engaged_fan, default: 0
      t.integer :fan_reach, default: 0
      t.integer :storytellers, default: 0

      t.timestamps
    end
  end
end
