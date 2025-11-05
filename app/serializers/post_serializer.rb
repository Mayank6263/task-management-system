class PostSerializer
  include FastJsonapi::ObjectSerializer

  attributes :uuid, :image, :caption, :user_uuid, :comments_count, :likes_count
end
