class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: %i[ update destroy]
  before_action :search, only: :search

  def index
    # debugger
    @posts = Post.all.paginate(page: params[:page], per_page: params[:per_page])
    pages = { total_pages: @posts.total_pages, current_page: params[:page].to_i, total_entries: @posts.total_entries }
    render json: PostSerializer.new(@posts, meta: pages)
  end

  def create
    post = @current_user.posts.new(post_params)
    if post.save!
      message = { message: "Post created successfully!", status: :ok }
      render json: PostSerializer.new(post,  meta: message)
    else
      render json: { message: "Post creation failed.", status: :unprocessable_entity }
    end
  end

  def show
    render json: PostSerializer.new(Post.find(params[:id])), status: :ok
  end

  def update
    if @post.update(post_params)
      message = { message: "Post Updated successfully!", status: :ok }
      render json: PostSerializer.new(@post, meta: message)
    else
      render json: { status: unprocessable_entity, message: "Updation failed." }
    end
  end

  def destroy
    if @post.destroy
      render json: { status: :ok, message: "Post deleted successfully." }
    end
  end

  def myposts
    @posts = @current_user.posts
    if @posts.empty?
      render json: { message: "You do not have Posts yet." }
    else
      render json: { Myposts: @posts, meta: { Count: @posts.count } }
    end
  end

  def search
    debugger
    @posts = Post.where("user_id = '#{params[:search].to_i}'").order(updated_at: :desc)
    @posts = @posts.paginate(page: params[:page], per_page: params[:per_page])
    render json: PostSerializer.new(@posts, meta: { total_pages: @posts.total_pages, current_page: params[:page].to_i, total_entries: @posts.total_entries })
  end

  private

  def post_params
    params.require(:post).permit(:image, :caption)
  end

  def set_post
    @post = @current_user.posts.find(params[:id])
  end
end
