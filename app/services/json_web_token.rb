require 'jwt'
class JsonWebToken

  # Encoding Jwt with expiration.
  def self.encode(payload, exp = 1.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, ENV['SECRET_KEY'], 'HS256')
  end

  # Decode JWT token Authentication.
  def self.decode(token)
    decoded = JWT.decode(token, ENV['SECRET_KEY'], true, algorithm: 'HS256')
    HashWithIndifferentAccess.new(decoded[0])
  rescue
    nil
  end
end