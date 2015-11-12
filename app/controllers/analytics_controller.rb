class AnalyticsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @post = WordpressPost.find_by(id: params[:post])

    if @post.present?
      start_date = params[:start_date].present? ? params[:start_date].to_date : Date.today
      end_date = params[:end_date].present? ? params[:end_date].to_date : Date.today - 7.days
      @analytics = Dsh::AnalyticsSearcher.new(start_date: start_date, end_date: end_date, post: @post)
    end

    @posts = WordpressPost.where("sessions > 100").where.not(title: nil).order(:title).all
  end

end
