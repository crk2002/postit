class PostsController < ApplicationController
  before_action :set_post_to_current, only: [:show, :edit, :update]
  
  def index
    @posts=Post.all
  end
  
  def show
    @comment=@post.comments.new
  end
  
  def new
    @post=Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.creator = User.first
    
    if @post.save
      flash[:notice] = "Your post was saved!"
      redirect_to @post
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @post.update(post_params)
      flash[:notice] = "Your post was updated!"
      redirect_to @post
    else
      render :edit
    end

  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :url, :description)
  end
  
  def set_post_to_current
    @post=Post.find params[:id]
  end

end