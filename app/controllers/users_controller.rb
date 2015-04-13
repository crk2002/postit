class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :get_two_auth, :verify_two_auth]
  before_action :can_register?, only: [:new, :create]
  before_action :authenticated_user?, only: [:edit, :update, :get_two_auth, :verify_two_auth]
  before_action :can_edit_user?, only: [:edit, :update, :get_two_auth, :verify_two_auth]

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
      session[:user] = @user.slug
      flash[:notice] = "User #{@user.username} was successfully created!"
      if @user.phone
        @user.update phone_verified: false
        @user.send_two_auth_code
        redirect_to get_two_auth_user_path(@user)
      else
        redirect_to root_path
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
    reverify_phone = @user.phone_changed?
    if @user.update(user_params)
      flash[:notice] = "User #{@user.username} was successfully updated!"
      if reverify_phone
        @user.update phone_verified: false
        @user.send_two_auth_code
        redirect_to get_two_auth_user_path(@user)
      else
        redirect_to root_path
      end
    else
      render :edit
    end
  end
  
  def get_two_auth
  end
  
  def verify_two_auth
    if params[:two_auth_code] == @user.two_auth_code
      @user.update(phone_verified: true)
      flash[:notice] = "Your phone number was successfully verified!"
      redirect_to @user
    else
      flash[:error] = "You did not enter the correct authentication code."
      render :get_two_auth
    end
  end

  private


  def set_user
    @user=User.find_by slug: params[:id]
  end

  def can_register?
    if logged_in?
      flash[:error] = "To register a new user, log out first."
      redirect_to root_path
    end
  end

  def can_edit_user?
    if params[:id] != session[:user].to_s
      flash[:error]="You cannot edit another user."
      redirect_to current_user
    end
  end

  def user_params
    params.require(:user).permit(:username, :password, :email, :phone)
  end

end
