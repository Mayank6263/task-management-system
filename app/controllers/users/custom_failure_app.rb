class Users::CustomFailureApp < Devise::FailureApp
  # debugger

  def respond
    if request.format == :json
      self.content_type = "application/json"
      self.status = 401
      self.response_body = { "code" => self.status, "msg" => "Invalid Credentials"}.to_json
    else
      super
    end
  end
end
