class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email, :name, :jti
end
