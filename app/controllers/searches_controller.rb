class SearchesController < ApplicationController
  def search
    @query = params[:query]
    @search_type = params[:search_type]

    @users = []
    @posts = []

    if @search_type == 'users'
      @users = User.where("name LIKE ?", "%#{@query}%").page(params[:page]).per(10)
    elsif @search_type == 'posts'
      @posts = Post.where("title LIKE ? OR text LIKE ?", "%#{@query}%", "%#{@query}%").page(params[:page]).per(10)
    else
      @users = User.page(params[:page]).per(10)
      @posts = Post.page(params[:page]).per(10)
    end

    @total_users = User.count
    @total_posts = Post.count
  end
end
