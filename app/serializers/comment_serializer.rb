class CommentSerializer
  include JSONAPI::Serializer
  attributes :body, :user_id, :commentable_id, :commentable_type
end
