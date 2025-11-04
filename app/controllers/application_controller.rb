class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  protect_from_forgery with: :null_session, if: -> { request.format.json? }
  skip_before_action :verify_authenticity_token
  rescue_from JWT::ExpiredSignature, with: :handle_expired_session
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :validation_failed

  before_action :authenticate_user
  # before_action :load_pagination, only: :index


  # def load_pagination
  #   # debugger
  #   @model = controller_name.classify.constantize.all
  #   @model = @model.paginate(page: params[:page], per_page: params[:per_page])
  #   # @model << page.to_i
  # end

  # def search
  # end

  private

  def handle_expired_session
    render json: { message: "token is Expired", code: 401 }
  end

  def record_not_found(exception)
    render json: { error: "#{exception.model} not found with id: #{exception.id}" }, status: :not_found
  end

  def validation_failed(exception)
    render json: { error: exception.message }, status: :unprocessable_entity
  end

  def authenticate_user
    token = request.headers["token"]

    if token.present?
      decoded = JwtService.decode(token)

      if decoded.nil?
        render json: { message: "Invalid or expired token" }, status: :unauthorized and return
      end

      id = decoded["user_id"]
      @current_user = User.find_by(id: id)

      unless @current_user
        render json: { message: "Invalid user" }, status: :unauthorized and return
      end

    else
      render json: { message: "Token missing" }, status: :unauthorized
    end
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:user, keys: %i[name email password])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name email])
    end
end
