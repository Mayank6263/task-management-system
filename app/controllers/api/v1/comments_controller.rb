class Api::V1::CommentsController < ApplicationController
  before_action :get_post
  before_action :find_comment, except: %i[index create postcomments]

  def index
    render json: CommentSerializer.new(@post.comments)
  end

  def create
    comment = @post.comments.new(comment_params)

    if comment.save!
      message = { message: "Comment created successfully!", status: :ok }
      render json: CommentSerializer.new(comment,  meta: message)
    else
      render json: { message: "Error in creating comment.", status: :unprocessable_entity }
    end
  end

  def show
    render json: CommentSerializer.new(@comment,  meta: { status: :ok })
  end

  def update
    if @comment.update(comment_params)
      message = { message: "Comment updated successfully.", status: :ok }
      render json: CommentSerializer.new(@comment,  meta: message)
    else
      render json: { message: "Updation failed.", status: :unprocessable_entity }
    end
  end

  def destroy
    if @comment.destroy
      render json: { message: "Comment deleted successfully.", status: :ok }
    else
      render json: { message: "Comment deletion failed.", status: :unprocessable_entity }
    end
  end

  def postcomments
    debugger
  end

  private

  def find_comment
    @comment = @post.comments.find(params[:id])
  end

  def get_post
    @post = Post.find(params[:post_id]) if params[:post_id]
    @post = Comment.find(params[:comment_id]) if params[:comment_id]
  end

  def comment_params
    params.require(:comment).permit(:body, :user_id)
  end
end
