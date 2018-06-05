class PostsController < ApplicationController
  before_action :logged_in_author
  def create
    @post = current_author.posts.build post_params
    if post.save
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    end
    
  end

  def destroy
    @post = current_author.posts.find_by(id: params[:id])
    post.destroy
  end

  private

  attr_reader :post
  def post_params
    params.require(:post).permit(:title, :content, :catalog, :picture)
  end

end
