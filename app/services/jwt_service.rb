# app/services/jwt_service.rb
class JwtService
  SECRET_KEY = Rails.application.secret_key_base.to_s

  # Encode a payload into a JWT
  def self.encode(payload, exp = 1.year.from_now)
    user = User.find_by(id: payload[:user_id])
    payload[:jti] = user.jti if user
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  # Decode a token and verify the user's jti
  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    body = HashWithIndifferentAccess.new(decoded)
    user = User.find_by(id: body[:user_id])

    # Verify that the user's jti matches the token's jti
    return nil unless user && user.jti == body[:jti]

    body
  rescue JWT::ExpiredSignature
    raise JWT::ExpiredSignature
  rescue JWT::DecodeError, ActiveRecord::RecordNotFound
    nil
  end
end
