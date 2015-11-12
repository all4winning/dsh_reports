class HomeController < ApplicationController

  def index
    @users = current_user.admin? ? User.editors.active.order(:id) : [current_user]
  end
end
