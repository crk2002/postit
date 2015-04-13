class CommentsController < ApplicationController
  
  before_action :authenticated_user?

  
  def create
    @post=Post.find_by slug: params[:post_id]
    @comment=@post.comments.build(params.require(:comment).permit(:body))
    @comment.post = @post
    @comment.creator = current_user
    if @comment.save
      flash[:notice] = "Your comment was added"
      redirect_to @post
    else
      flash[:error] = "Your comment was invalid!"
      redirect_to @post
    end
  end
  
  def vote
    @comment=Comment.find params[:id]
    vote = @comment.votes.find_or_initialize_by(user: current_user)
    vote.vote = params[:vote]
    vote.save
    
    respond_to do |format|
      format.html {redirect_to :back}
      format.js
    end
  end
  
end
