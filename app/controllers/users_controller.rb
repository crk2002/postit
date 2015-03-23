class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update]
  before_action :can_register?, only: [:new, :create]
  before_action :authenticated_user?, only: [:edit, :update]
  before_action :can_edit_user?, only: [:edit, :update]

  def show
    @posts=@user.posts
    @comments=@user.comments
  end

  def new
    @user=User.new
  end
  
  def create
    @user=User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "User #{@user.username} was successfully created!"
      redirect_to root_path
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:notice] = "User #{@user.username} was successfully updated!"
      redirect_to root_path
    else
      render :edit
    end
  end
  
  private
  
  def set_user
    @user=User.find params[:id]
  end
  
  def can_register?
    if logged_in?
      flash[:error] = "To register a new user, log out first."
      redirect_to root_path
    end
  end
  
  def can_edit_user?
    if params[:id] != session[:user_id].to_s
      flash[:error]="You cannot edit another user."
      redirect_to current_user
    end
  end
  
  def user_params
    params.require(:user).permit(:username, :password, :email)
  end
  
end
