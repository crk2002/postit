class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :logged_in?, :admin?, :current_user
  
  def current_user
    @current_user ||= User.find_by slug: session[:user] if session[:user]
  end
  
  def logged_in?
    !!current_user
  end
  
  def admin?
    current_user.admin == true if current_user
  end
  
  def authenticated_user?
    if !logged_in?
      flash[:error] = "You need to login first!"
      redirect_to login_path
    end
  end
  
  def admin_user?
    if !logged_in? || !admin?
      flash[:error] = "You do not have the required privileges!"
      redirect_to :root
    end
  end

end
