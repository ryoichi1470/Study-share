class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def mypage
    @user = current_user # 現在のユーザー
    @posts = @user.posts  # 現在のユーザーの投稿
  end

  def show
    @posts = @user.posts # 特定ユーザーの投稿を表示
  end

  private

  def set_user
    @user = User.find(params[:id]) # URLからIDを取得してユーザーを検索
  end
end
