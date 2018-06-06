class CommentsController < ApplicationController
  before_action :find_post
  def create
    @comment = post.comments.build comment_params
    if comment.save
      respond_to do |format|
        format.html { redirect_to post }
        format.js
      end
    end
  
  end

  def destroy
    @comment = post.comments.find_by(id: params[:id])
    # redirect_to post_path unless comment
    comment.destroy
    respond_to do |format|
      format.html { redirect_to post  }
      format.js
    end
  end

  private
  attr_reader :post,:comment
  def comment_params
    params.require(:comment).permit(:content,:author_id)
  end
  def find_post
    @post = Post.find_by(id: params[:post_id])
    return if post
    flash[:danger] = "fail post"
    redirect_to root_path
  end

end
