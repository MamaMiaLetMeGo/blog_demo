class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @comment = @post.comments.create(comment_params)
    @comment.user = current_user

      if @comment.save
        flash[:notice] = "My god you are opinionated(but I love the attention <3), love Charlie"
        redirect_to post_path(@post)
      else
        flash[:alert] = "Something went wrong you dingleberry, your comment did not go through"
      end
  end

  def update
    @comment = @post.comments.find(params[:id])

    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to post_url(@post), notice: 'Your comment has been updated fool' }
      else
        format.html { redirect_to post_url(@post), alert: 'What the heck, your comment was not updated' }
      end
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
