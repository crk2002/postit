class SessionsController < ApplicationController

  def new
    session[:return_to] = request.referer
  end
  
  def create
    user=User.find_by username: params[:username]
    if user && user.authenticate(params[:password])
      session[:user] = user.slug
      if session[:return_to]
        redirect_to session.delete(:return_to)
      else
        redirect_to root_path
      end
    else
      flash[:error] = "There was an error in your login credentials"
      render :new
    end
  end
  
  def destroy
    flash[:notice] = "User #{current_user.username} was successfully logged out!"
    session[:user] = nil
    redirect_to :back
  end
    
end
