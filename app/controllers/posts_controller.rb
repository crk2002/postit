class PostsController < ApplicationController
  
  before_action :set_post_to_current, only: [:show, :edit, :update, :vote]
  before_action :authenticated_user?, only: [:new, :create, :edit, :update, :vote]
  
  def index
    @posts=Post.all.sort_by(&:total_votes).reverse
  end
  
  def show
    @comment=Comment.new
  end
  
  def new
    @post=Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.creator = current_user
    
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
  
  def vote
    vote = @post.votes.find_or_initialize_by(user: current_user)
    vote.vote = params[:vote]
    vote.save
    redirect_to :back
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end
  
  def set_post_to_current
    @post=Post.find params[:id]
  end

end