class SearchesController < ApplicationController
  def search
    if params[:query].present?
      query = params[:query].strip
      @users = User.where('name LIKE ?', "%#{query}%")
      @posts = Post.where('title LIKE ? OR text LIKE ?', "%#{query}%", "%#{query}%")
    else
      @users = User.all
      @posts = Post.all
    end
  end
end
