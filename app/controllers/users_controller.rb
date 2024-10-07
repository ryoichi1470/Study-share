class UsersController < ApplicationController
  before_action :authenticate_user!

  def mypage
    if current_user.guest?
      redirect_to users_posts_path, alert: "ゲストユーザーはマイページにアクセスできません。" 
    else
      @user = current_user
      @posts = @user.posts
    end
  end
end
