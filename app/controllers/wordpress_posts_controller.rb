class WordpressPostsController < ApplicationController

   SORT_FIELDS = ActiveSupport::HashWithIndifferentAccess.new({:"Created"=> "created_time", :"Users"=> "users", :"Page Views"=> "unique_page_views", :"Page Views Per User"=> "page_views_per_user", :"Average Time On Page"=> "average_time_on_page"})

  before_filter :authenticate_user!

  def index
    @sort_fields = SORT_FIELDS.keys
    @users = User.editors if current_user.admin? || current_user.id == 10
    @wordpress_posts = current_user.admin? || current_user.id == 10 ? WordpressPost.all : current_user.wordpress_posts
    @wordpress_posts = apply_filters(@wordpress_posts).paginate(page: params[:page])
  end

  private

  def apply_filters(wordpress_posts)
    if params[:title].present?
      wordpress_posts = wordpress_posts.where("lower(title) LIKE :title", title: "%#{params[:title].downcase}%")
    end

    if params[:author].present?
      wordpress_posts = wordpress_posts.where(wordpress_user_id: params[:author])
    end

    if params.fetch(:created, {}).fetch(:from, '').present?
      wordpress_posts = wordpress_posts.where("created_time >= ?", DateTime.strptime(params[:created][:from], "%m/%d/%Y"))
    end

    if params.fetch(:created, {}).fetch(:to, '').present?
      wordpress_posts = wordpress_posts.where("created_time <= ?", DateTime.strptime(params[:created][:to], "%m/%d/%Y").end_of_day)
    end

    if params.fetch(:users, {}).fetch(:from, '').present?
      wordpress_posts = wordpress_posts.where("users >= ?", params[:users][:from])
    end

    if params.fetch(:users, {}).fetch(:to, '').present?
      wordpress_posts = wordpress_posts.where("users <= ?", params[:users][:to])
    end

    if params.fetch(:page_views, {}).fetch(:from, '').present?
      wordpress_posts = wordpress_posts.where("unique_page_views >= ?", params[:page_views][:from])
    end

    if params.fetch(:page_views, {}).fetch(:to, '').present?
      wordpress_posts = wordpress_posts.where("unique_page_views <= ?", params[:page_views][:to])
    end

    if params.fetch(:average_time_on_page, {}).fetch(:from, '').present?
      wordpress_posts = wordpress_posts.where("average_time_on_page >= ?", params[:average_time_on_page][:from])
    end

    if params.fetch(:average_time_on_page, {}).fetch(:to, '').present?
      wordpress_posts = wordpress_posts.where("average_time_on_page <= ?", params[:average_time_on_page][:to])
    end

    if params[:sort].present? && params[:order].present?
      wordpress_posts = wordpress_posts.order("#{SORT_FIELDS[params[:sort]]} #{params[:order]}")
    else
      wordpress_posts = wordpress_posts.order(created_time: :desc)
    end

    wordpress_posts
  end
end
