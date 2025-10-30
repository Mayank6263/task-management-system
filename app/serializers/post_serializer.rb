class PostSerializer
  include FastJsonapi::ObjectSerializer

  attributes :image, :caption, :user_id
end
