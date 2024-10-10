class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authorize_user!, only: [:edit]
  before_action :check_guest_user, only: [:mypage]

  def mypage
    @user = current_user 
    @posts = @user.posts  
  end

  def show
    @posts = @user.posts 
  end

  private

  def set_user
    @user = User.find(params[:id]) 
  end
  
  def authorize_user!
    redirect_to mypage_path unless @user == current_user
  end
  
  def check_guest_user
    if current_user.guest?
      redirect_to users_posts_path, alert: "ゲストユーザーはマイページにアクセスできません。"
    end
  end
end
