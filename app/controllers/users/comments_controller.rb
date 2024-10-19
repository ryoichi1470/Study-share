class Users::CommentsController < ApplicationController
  before_action :set_post, only: [:edit, :create, :update, :destroy]
  before_action :set_comment, only: [:edit, :update, :destroy]

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
  end


  def edit
    set_post
    set_comment
  end

  def update
    if @comment.update(comment_params)
      redirect_to users_post_path(@post), notice: 'コメントが更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
