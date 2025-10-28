class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  protect_from_forgery with: :null_session, if: -> { request.format.json? }
  # skip_before_action :verify_authenticity_token
  rescue_from JWT::ExpiredSignature, with: :handle_expired_session
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :validation_failed

  before_action :authenticate_user
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def handle_expired_session
    render json: { message: "token is Expired", code: 401 }
  end

  def record_not_found(exception)
    render json: { error: "#{exception.model} not found with id: #{exception.id}" }, status: :not_found
  end

  def validation_failed(exception)
    # debugger
    render json: {error: exception.message}, status: :unprocessable_entity
  end

  def authenticate_user
    if request.headers['token'].present?
      id = JWT.decode(request.headers[:token], Rails.application.credentials.devise_jwt_secret_key!).first['sub']
      @current_user = User.find(id)
    else
      render json: { message: "Invalid token", code: 401 }
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name email])
  end
end
