class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :check_guest_user, only: [:mypage]
  before_action :correct_user, only: [:edit, :update]

  def mypage
    @user = current_user 
    @posts = @user.posts  
  end

  def show
    @posts = @user.posts 
  end

  def edit
  
  end

  def update
    if @user.update(user_params)
      redirect_to mypage_path, notice: 'プロフィールが更新されました。'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id]) 
  end
  
  def user_params
    params.require(:user).permit(:name, :email) 
  end
  
  def correct_user
    unless current_user == @user || current_user.admin?
      redirect_to mypage_path(current_user), alert: "編集権限がありません。"
    end
  end
  
  def check_guest_user
    if current_user.guest?
      redirect_to users_posts_path, alert: "ゲストユーザーはマイページにアクセスできません。"
    end
  end
  

  
end
