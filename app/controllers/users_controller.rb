class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :check_guest_user, only: [:mypage]
  before_action :correct_user, only: [:edit, :update]
  before_action :authenticate_user!, only: [:edit, :update]

  def mypage
    @user = current_user 
    @posts = @user.posts.page(params[:page]).per(5)
  end

  def show
    @posts = @user.posts 
  end

  def edit
  
  end

  def update
    if @user.update_with_password(user_params)
      bypass_sign_in(@user)
      redirect_to mypage_path, notice: 'プロフィールが更新されました。'
    else
      flash[:alert] = '入力にエラーがあります。再度確認してください。'
      redirect_to edit_user_registration_path 
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
    if current_user.nil?
      redirect_to new_user_session_path, alert: "ログインが必要です。"
    elsif current_user != @user && !current_user.admin?
      redirect_to mypage_path(current_user)
    end
  end
  
  def check_guest_user
    if current_user.guest?
      redirect_to users_posts_path, alert: "ゲストユーザーはマイページにアクセスできません。"
    end
  end
  

  
end
