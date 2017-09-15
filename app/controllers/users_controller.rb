class UsersController < ApplicationController
  before_action :require_admin

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to users_url
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:role, :email, :password, :password_confirmation)
    end

    def require_admin
      unless current_user.admin?
        redirect_to root_path, :alert => "Access denied."
      end
    end
end
