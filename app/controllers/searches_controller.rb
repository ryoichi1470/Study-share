class SearchesController < ApplicationController
  def search
    if params[:query].present?
      @users = User.where('name LIKE ?', "%#{params[:query]}%")
      @posts = Post.where('title LIKE ? OR text LIKE ?', "%#{params[:query]}%", "%#{params[:query]}%")
    else
      @users = User.none
      @posts = Post.none
    end
  end
end
