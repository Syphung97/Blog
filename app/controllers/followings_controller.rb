class FollowingsController < ApplicationController
  attr_reader :author

  before_action :logged_in_author, :find_author, only: :index

  def index
    @title = "following"
    @authors = author.following.paginate page: params[:page]
    render "authors/show_follow"
  end

  private

  def find_author
    @author = Author.find_by id: params[:id]

    return if author
    flash[:success] = "failed_author"
    redirect_to root_path
  end
end
