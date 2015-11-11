class WordpressPost < ActiveRecord::Base

  belongs_to :user, :class_name => 'User', foreign_key: "wordpress_user_id", primary_key: "wordpress_user_id"
  has_many :facebook_posts, :class_name => 'FacebookPost', foreign_key: "wordpress_id", primary_key: "wordpress_id"

  def self.recent
    if Time.current.mday > 10
      WordpressPost.where(created_time: Time.current.beginning_of_month..Time.current)
    else
      WordpressPost.where(created_time: (Time.current.beginning_of_month - 30.days)..Time.current)
    end
  end
end
