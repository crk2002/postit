class CategoriesController < ApplicationController

  before_action :admin_user?, only: [:new, :create]

  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "New category was added!"
      redirect_to posts_path
    else
      render :new
    end
  end  
  
  def show
    @category = Category.find_by slug: params[:id]
    @posts = @category.posts.all
  end
  
  private
  
  def category_params
    params.require(:category).permit(:name)
  end
  
end
