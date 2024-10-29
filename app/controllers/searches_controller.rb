class SearchesController < ApplicationController
  def search
    @query = params[:query]
    @search_type = params[:search_type]
    page = params[:page].to_i > 0 ? params[:page].to_i : 1  
  
    @users = []
    @posts = []
  
    if @search_type == 'users'
      @users = User.where("name LIKE ?", "%#{@query}%").page(page).per(10)
    elsif @search_type == 'posts'
      @posts = Post.where("title LIKE ? OR text LIKE ?", "%#{@query}%", "%#{@query}%").page(page).per(10)
    else
      @users = User.all.page(page).per(10)
      @posts = Post.all.page(page).per(10)
    end
  
    @total_users = User.count
    @total_posts = Post.count
  
    @current_page = page
  end

end
