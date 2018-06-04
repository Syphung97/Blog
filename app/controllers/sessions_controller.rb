class SessionsController < ApplicationController

  def new; end

  def create
    @author = Author.find_by(email: session_params[:email].downcase)
    if author && author.authenticate(session_params[:password])
      login author
      session_params[:remember_me] == '1' ? remember(author) : forget(author)
      redirect_to author
    else
      flash.now[:danger] = "Login false"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  private

  attr_reader :author

  def session_params
    params[:session]
  end

end
