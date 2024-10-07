class Users::PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
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
    @posts = Post.all
  end

  def show
    # ここは変更なし
  end

  def edit
    # ここは変更なし
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
    redirect_to users_posts_path, notice: '投稿が削除されました。'
  end

  private

  def set_post
    @post = Post.find(params[:id])  # 変更: current_user.postsから外す
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
 
  def correct_user
    # 現在のユーザーが投稿の所有者でない場合、リダイレクト
    redirect_to users_posts_path, alert: "権限がありません。" unless @post.user == current_user
  end

  # ゲストユーザーの場合、特定のアクションへのアクセスを制限
  def restrict_guest_user
    if current_user.guest?
      redirect_to users_posts_path, alert: "ゲストユーザーはこの操作を実行できません。"
    end
  end
end
