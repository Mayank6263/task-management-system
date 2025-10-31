class Api::V1::SessionsController < Devise::SessionsController
  before_action :sign_in_params, only: :create
  before_action :load_user, only: [ :create ]
  skip_before_action :authenticate_user, only: :create


  def create
    if @user&.valid_password?(sign_in_params[:password])
      token = JwtService.encode(user_id: @user.id)
      sign_in("user", @user)
      message = { message: "Signed In Successfully.", token: token }
      render json: UserSerializer.new(@user, meta: message)
    end
  end

  def destroy
    if verify_signed_out_user
      request.headers["token"] = ""
      render json: { messages: "Signed Out Successfully.", status: :ok }
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
