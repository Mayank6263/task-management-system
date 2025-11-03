class PostSerializer
  include FastJsonapi::ObjectSerializer

  attributes :image, :caption, :user_id, :comments_count, :likes_count
end
