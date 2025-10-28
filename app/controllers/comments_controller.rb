class CommentsController < ApplicationController
  before_action :authenticate_user
  before_action :set_post
  before_action :set_comment, only: %i[show update destroy]



  def index
    render json: { status: 200, comments: @post.comments}, status: :ok
  end

  def create
    debugger
    comment = @post.comments.new(comment_params)

    if comment.save!
      render json: { status: 200, message: 'comment created successfully.', comment: comment }, status: :ok
    else
      render json: { status: 422, message: "Error in creating comment.", comment: comment }, status: :unprocessable_entity
    end
  end

  def show
    # debugger
    render json: { status: 200, comment: @comment }, status: :ok

  end

  def update
    if @comment.update(comment_params)
      render json: { status: 200, message: 'Comment updated successfully.', comment: @comment }, status: :ok
    else
      render json: { status: 422, message: 'Updation failed.' }, status: :unprocessable_entity
    end
  end

  def destroy
    if @comment.destroy
      render json: {status: 200, message: 'Comment deleted successfully.'}, status: :ok
    else
      render json: {status: 422, message: 'Comment deletion failed.'}, status: :unprocessable_entity
    end
  end

  private

  def set_post
    @post = @current_user.posts.find(params[:post_id]) if params[:post_id]
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
