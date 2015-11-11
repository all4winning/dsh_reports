class User < ActiveRecord::Base
  devise :omniauthable, :omniauth_providers => [:facebook]

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :wordpress_user_id, presence: true
  validates :facebook_email, presence: true, uniqueness: true

  has_many :facebook_posts, :class_name => 'FacebookPost', foreign_key: "facebook_user_id", primary_key: "uid"
  has_many :wordpress_posts, :class_name => 'WordpressPost', foreign_key: "wordpress_user_id", primary_key: "wordpress_user_id"

  scope :admins, -> { where(admin: true) }
  scope :editors, -> { where(admin: false) }
  scope :active, -> { where(active: true) }

  def self.from_omniauth(auth)
    user = User.active.where(facebook_email: auth.info.email).first
    user = User.active.where(uid: auth.uid).first unless user.present?

    if user.present?
      user.provider = auth.provider
      user.uid = auth.uid
      user.facebook_email = auth.info.email
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.profile_image_url = auth.info.image
      user.access_token = auth.credentials.token
      user.access_token_expires_at = Time.at(auth.credentials.expires_at) if auth.credentials.expires_at.present?
      user.save
    end

    user
  end

  def name
    first_name + ' ' + last_name
  end

  def current_facebook_stats
    @current_facebook_stats ||= Statistics::Facebook.new(self)
  end

  def previous_facebook_stats
    previous_month = Date.current - 1.month
    @previous_facebook_stats ||= Statistics::Facebook.new(self, previous_month.beginning_of_month.beginning_of_day, previous_month.end_of_month.end_of_day)
  end

  def current_wordpress_stats
    @current_wordpress_stats ||= Statistics::Wordpress.new(self)
  end

  def wordpress_stats(date)
    Statistics::Wordpress.new(self, date.beginning_of_month.beginning_of_day, date.end_of_month.end_of_day)
  end

  def previous_wordpress_stats
    previous_month = Date.current - 1.month
    @previous_wordpress_stats ||= Statistics::Wordpress.new(self, previous_month.beginning_of_month.beginning_of_day, previous_month.end_of_month.end_of_day)
  end

  def current_earnings_stats
    @current_earnings_stats ||= Statistics::Earnings.new(self)
  end

  def previous_earnings_stats
    previous_month = Date.current - 1.month
    @previous_earnings_stats ||= Statistics::Earnings.new(self, previous_month.beginning_of_month.beginning_of_day, previous_month.end_of_month.end_of_day)
  end
end
