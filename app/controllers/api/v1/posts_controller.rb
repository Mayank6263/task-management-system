class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: %i[show update destroy]

  def index
    # debugger
    posts = Post.all
    posts = posts.where(['caption LIKE ?', "#{params[:search]}"]) if params[:search].present?
    posts = posts.paginate(page: params[:page].to_i, per_page: params[:per_page])

    # ( params[:caption] == Post.where(['caption ILIKE ?', "#{params[:caption]}"]) )?
    #   @posts =  Post.where(['caption LIKE ?', "#{params[:caption]}"])
    # :
    #   @posts = Post.paginate(page: params[:page], per_page: params[:per_page])
  
    # render json: PostSerializer.new(posts), status: :ok
    render json: PostSerializer.new(posts, meta: { total_pages: posts.total_pages, current_page: posts.page[:page], total_entries: posts.total_entries })

  end

  def create
    post = @current_user.posts.new(post_params)
    if post.save!
      render json: PostSerializer.new(post,  meta: { message: "Post created successfully!" }), status: :ok
    else
      render json: { status: 422, message: 'Post creation failed.' }, status: :unprocessable_entity
    end
  end

  def show
    render json: PostSerializer.new(@post), status: :ok
  end

  def update
    # debugger
    if @post.update(post_params)
      render json: PostSerializer.new(@post, meta: { message: "Post Updated successfully!" }), status: :ok
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

  # def search
  #   debugger
  #   search_post = return Post.all unless search == Post.where(['image LIKE ?', "%#{search}%"])
  #   render json: { users: search_post }, status: :ok
  # end

  private

  def post_params
    params.require(:post).permit(:image, :caption)
  end

  def set_post
    @post = @current_user.posts.find(params[:id])
  end
end
