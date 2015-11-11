class StatisticsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @user = User.find_by(id: params[:author])
    @users = User.editors if current_user.admin?
  end

end
