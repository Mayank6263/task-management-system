class Api::V1::LikesController < ApplicationController
  before_action :get_likeable

  def create
    like = @likeable.likes.new(like_params)

    like.save!
    render json: { post: @likeable, message: "User #{like.user_id} liked post." }
  end

  def destroy
    like = @likeable.likes.find(params[:id])
    like.destroy
    render json: { message: "Unliked Post/Comment." }
  end

  private

  def like_params
    params.require(:like).permit(:liked, :user_id)
  end

  def get_likeable
    @likeable = Comment.find(params[:comment_id]) if params[:comment_id]
    @likeable = Post.find(params[:post_id]) if params[:post_id]
  end
end
