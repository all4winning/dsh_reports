class WordpressPost < ActiveRecord::Base

  belongs_to :user, :class_name => 'User', foreign_key: "wordpress_user_id", primary_key: "wordpress_user_id"
  has_many :facebook_posts, -> { order("created_time desc") }, :class_name => 'FacebookPost', foreign_key: "wordpress_id", primary_key: "wordpress_id"

  scope :lists, -> { where(list: true) }
  scope :news, -> { where(list: false) }
  scope :by_wordpress_user_id, -> wordpress_user_id { where(wordpress_user_id: wordpress_user_id) }
  
  def self.recent
    if Time.current.mday > 10
      WordpressPost.where(created_time: Time.current.beginning_of_month..Time.current)
    else
      WordpressPost.where(created_time: (Time.current.beginning_of_month - 30.days)..Time.current)
    end
  end

  def calculate_earnings
    self.earnings = earnings_calculator.earnings
  end

  private

  def earnings_calculator
    Dsh::EarningsCalculator.new(self, user)
  end
end
