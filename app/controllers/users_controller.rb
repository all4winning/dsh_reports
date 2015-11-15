class UsersController < ApplicationController

  before_filter :authenticate_user!
  before_filter :find_user, except: [:index, :new, :create]
  before_filter :authorize_user

  def index
    @users = User.order(:id).paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new
    if @user.update_attributes(user_params)
      flash[:success] = 'New user added!'
      redirect_to users_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = 'Changes saved!'
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:success] = 'User deleted!'
    redirect_to users_path
  end

  def login_as
    sign_in(:user, @user)
    redirect_to root_path
  end

  def update_earnings
    WordpressPost.by_wordpress_user_id(@user.wordpress_user_id).each do |post|
      post.calculate_earnings
      post.save
    end
    flash[:success] = 'Earnings updated!'
    redirect_to users_path
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :facebook_email,
      :wordpress_user_id,
      :uid,
      :admin,
      :active,
      :base_page_views_per_list,
      :price_per_list,
      :price_per_news,
      :above_base_price,
      :bellow_base_price
    )
  end
end
