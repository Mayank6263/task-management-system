class CommentSerializer
  include JSONAPI::Serializer
  attributes :body, :user_id
end
