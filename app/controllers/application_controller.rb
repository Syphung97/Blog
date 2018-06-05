class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  private
  def logged_in_author
    return if logged_in?
    flash[:danger] = "Please loggin before update"
    redirect_to root_path
  end
end
