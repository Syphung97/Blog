class AuthorsController < ApplicationController
  before_action :find_author, only: [:edit, :update, :show]
  before_action :logged_in_author, only: [:edit, :update]
  before_action :correct_author, only: [:edit, :update]
  before_action :admin?, only: :destory
  def index
    @author = Author.paginate(page: params[:page])
  end

  def new
    @author = Author.new
  end

  def show 
    @posts = author.posts.desc.paginate(page: params[:page], per_page: 5)
    @supports = Supports::Author.new author: author, current_author: current_author
  end

  def create
    @author  = Author.new author_params
    if author.save
      flash[:success] = "Sign up success!"
      redirect_to author
    else
      render :new
    end

  end

  def edit; end

  def update
    if author.update_attributes author_params
      flash[:success] = "Update Complete"
      redirect_to author
    else
      render :edit
    end
  end

  def destroy
    @id = params[:id]
    Author.find_by(id: params[:id]).destroy
    respond_to do |format|
      format.js
    end
  end

  private
  attr_reader :author

  def author_params
    params.require(:author).permit(:name, :email, :password, :password_confirmation)
  end

  def find_author
    @author = Author.find_by(id: params[:id])
    return if author
    flash[:danger] = "Author error"
    redirect_to root_path
  end

  def correct_author
    redirect_to root_path unless author.current_author? current_author
  end

  def admin?
    redirect_to root_path unless current_author.admin?
  end

end
