class HomeController < ApplicationController

  def index
    @users = User.editors.active.order(:id)
  end
end
