class Api::V1::SessionsController < Devise::SessionsController
  before_action :sign_in_params, only: :create
  before_action :load_user, only: [ :create ]
  skip_before_action :authenticate_user, only: :create
  skip_before_action :verify_signed_out_user, only: :destroy

  def create
    # debugger
    if @user&.valid_password?(sign_in_params[:password])
      token = JwtService.encode(user_uuid: @user.id)
      sign_in("user", @user)
      message = { message: "Signed In Successfully.", token: token }
      render json: UserSerializer.new(@user, meta: message)
    end
  end

  def show
  end

  def update
  end

  def destroy
    # debugger
    if @current_user
      @current_user.update_column(:jti, SecureRandom.uuid)
      render json: { message: "Signed Out Successfully" }, status: :ok
    else
      render json: { message: "Invalid or expired token" }, status: :unauthorized
    end
  end

  private

  def sign_in_params
    params.require(:sign_in).permit(:email, :password)
  end

  def load_user
    @user = User.find_for_database_authentication(email: sign_in_params[:email])
    unless @user
      render json: { messages: "Cannot find user", status: :not_found, data: {} }
    end
  end
end
