class PostsController < ApplicationController
  before_action :logged_in_author, only: [:create, :destory]

  def index
    if params[:term]
      @post = Post.search("%#{params[:term]}%")
    end
  end

  def create
    @post = current_author.posts.build post_params
    if post.save
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    end
    
  end

  def show
    @post = Post.find_by(id: params[:id])
    @new_comment = post.comments.build
    @comments = post.comments.paginate(page: params[:page])
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
