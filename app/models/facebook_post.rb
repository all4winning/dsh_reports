class FacebookPost < ActiveRecord::Base

  scope :no_insights, -> { where(impressions: 0) }

  belongs_to :user, :class_name => 'User', foreign_key: "uid", primary_key: "facebook_user_id"
  belongs_to :wordpress_post, :class_name => 'WordpressPost', foreign_key: "wordpress_id", primary_key: "wordpress_id"

  def self.recent
    if Time.current.mday > 10
      FacebookPost.where(created_time: Time.current.beginning_of_month..Time.current)
    else
      FacebookPost.where(created_time: (Time.current.beginning_of_month - 30.days)..Time.current)
    end
  end
end
