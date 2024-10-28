class Users::PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :show, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :restrict_guest_user, only: [:new, :create, :edit, :update, :destroy]

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to users_post_path(@post), notice: '投稿が作成されました。'
    else
      render :new
    end
  end

  def index
    @posts = Post.page(params[:page]).per(4)
  end

  def show
    @comments = @post.comments
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "投稿が更新されました！"
      redirect_to users_post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to mypage_path
  end

  private

  def set_post
    @post = Post.find_by(id: params[:id])
    unless @post
      redirect_to users_posts_path, alert: "投稿が見つかりませんでした。"
    end
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def correct_user
    redirect_to users_posts_path, alert: "権限がありません。" unless @post.user == current_user
  end

  def restrict_guest_user
    if current_user.guest?
      redirect_to users_posts_path, alert: "ゲストユーザーは投稿一覧以外のページにアクセスできません"
    end
  end
end
