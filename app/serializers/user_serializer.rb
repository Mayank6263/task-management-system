class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :uuid, :email, :name, :jti
  attribute :id, if: Proc.new {| record | false }
end
