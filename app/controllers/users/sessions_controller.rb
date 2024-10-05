class Users::SessionsController < ApplicationController
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to about_path, notice: 'ゲストユーザーとしてログインしました。'
  end
  
  def destroy
    sign_out(current_user)
    redirect_to root_path, notice: 'ログアウトしました。'
  end
  
end
