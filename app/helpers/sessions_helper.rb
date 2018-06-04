module SessionsHelper
  def login author
    session[:author_id] = author.id
  end

  def current_author
    if(author_id = session[:author_id])
      @current_author ||= Author.find_by(id: author_id)
    elsif cookies_id = cookies[:author_id]
      author = Author.find_by(id: cookies_id)
      if author && author.authenticated?(cookies_id)
        login author
        @current_author = author
      end
    end
  end

  def logged_in?
    !current_author.nil?
  end

  def log_out
    forget current_author
    session.delete :author_id
    @current_author = nil
  end

  def remember author
    author.remember
    cookies.permanent.signed[:author_id] = author.id
    cookies.permanent[:remember_token] = author.remember_token
  end

  def forget author
    author.forget
    cookies.delete(:author_id)
    cookies.delete(:remember_token)
  end

end
