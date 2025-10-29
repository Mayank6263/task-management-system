class PostsController < ApplicationController
  before_action :set_post, only: %i[show update destroy]

  def index
    posts = @current_user.posts.order(:updated_at)
    render json: { data: { posts: posts } }, status: :ok
  end

  def create
    post = @current_user.posts.new(post_params)
    if post.save!
      render json: { status: 200, message: 'Post created successfully.', post: post }, status: :ok
    else
      render json: { status: 422, message: 'Post creation failed.' }, status: :unprocessable_entity
    end
  end

  def show
    render json: { status: 200, post: @post }, status: :ok
  end

  def update
    if @post.update(post_params)
      render json: { status: 200, message: 'Post updated successfully.', post: @post }, status: :ok
    else
      render json: { status: 422, message: 'Updation failed.' }, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.destroy
      render json: {status: 200, message: 'Post deleted successfully.'}, status: :ok
    else
      render json: {status: 422, message: 'Post deletion failed.'}, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:image, :caption)
  end

  def set_post
    @post = @current_user.posts.find(params[:id])
  end
end
