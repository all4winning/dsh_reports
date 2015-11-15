class AnalyticsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @post = WordpressPost.find_by(id: params[:post])

    if @post.present?
      @start_date = params[:start_date].present? ? Date.strptime(params[:start_date], "%m/%d/%Y") : Date.today
      @end_date = params[:end_date].present? ? Date.strptime(params[:end_date], "%m/%d/%Y") : Date.today - 7.days
      @analytics = Dsh::AnalyticsSearcher.new(start_date: @start_date, end_date: @end_date, post: @post)
    end

    @posts = WordpressPost.where("sessions > 100").where("title is not null or title != ''").order(:title)
  end

end
