class HomeController < ApplicationController

  def index
    if current_user.present?
      @users = current_user.admin? ? User.where.not(id: 10).editors.active.order(:id) : [current_user]
    end
  end
end
