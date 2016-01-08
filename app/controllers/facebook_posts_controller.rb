class FacebookPostsController < ApplicationController

  SORT_FIELDS = ActiveSupport::HashWithIndifferentAccess.new({:"Created"=> "created_time", :"Impressions"=> "impressions_unique", :"Organic Impressions"=> "impressions_organic_unique", :"Clicks"=> "consumptions_unique"})

  before_filter :authenticate_user!

  def index
    @sort_fields = SORT_FIELDS.keys
    @users = User.editors if current_user.admin?
    @facebook_posts = current_user.admin? ? FacebookPost.all : current_user.facebook_posts
    @facebook_posts = apply_filters(@facebook_posts).paginate(page: params[:page])
  end

  private

  def apply_filters(facebook_posts)
    if params[:wordpress_post].present?
      facebook_posts = facebook_posts.where(wordpress_id: params[:wordpress_post])
    end

    if params[:title].present?
      facebook_posts = facebook_posts.where("lower(name) LIKE :title", title: "%#{params[:title].downcase}%")
    end

    if params[:author].present?
      facebook_posts = facebook_posts.where(facebook_user_id: params[:author])
    end

    if params.fetch(:created, {}).fetch(:from, '').present?
      facebook_posts = facebook_posts.where("created_time >= ?", DateTime.strptime(params[:created][:from], "%m/%d/%Y"))
    end

    if params.fetch(:created, {}).fetch(:to, '').present?
      facebook_posts = facebook_posts.where("created_time <= ?", DateTime.strptime(params[:created][:to], "%m/%d/%Y").end_of_day)
    end

    if params.fetch(:impressions, {}).fetch(:from, '').present?
      facebook_posts = facebook_posts.where("impressions_unique >= ?", params[:impressions][:from])
    end

    if params.fetch(:impressions, {}).fetch(:to, '').present?
      facebook_posts = facebook_posts.where("impressions_unique <= ?", params[:impressions][:to])
    end

    if params.fetch(:clicks, {}).fetch(:from, '').present?
      facebook_posts = facebook_posts.where("consumptions_unique >= ?", params[:clicks][:from])
    end

    if params.fetch(:clicks, {}).fetch(:to, '').present?
      facebook_posts = facebook_posts.where("consumptions_unique <= ?", params[:clicks][:to])
    end

    if params[:sort].present? && params[:order].present?
      facebook_posts = facebook_posts.order("#{SORT_FIELDS[params[:sort]]} #{params[:order]}")
    else
      facebook_posts = facebook_posts.order(created_time: :desc)
    end

    facebook_posts
  end
end
