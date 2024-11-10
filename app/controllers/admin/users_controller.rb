class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user
  before_action :set_user, only: [:toggle_active]

  def index
    @users = User.all
  end
  
  def show
  end 

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "User was successfully deleted."
  end
  
  def toggle_active
    @user.update(active: !@user.active)
    redirect_to admin_users_path, notice: "ユーザーの状態を更新しました。"
  end

  private

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
end
