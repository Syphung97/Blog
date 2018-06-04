class AuthorsController < ApplicationController
 
  def new
    @author = Author.new
  end

  def show
    @author = Author.find_by(id: params[:id])
  end

  def create
    @author  = Author.new author_params
    if author.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to author
    else
      render :new
    end
    
  end

  private
  attr_reader :author
  def author_params
    params.require(:author).permit(:name, :email, :password, :password_confirmation)
  end

end
