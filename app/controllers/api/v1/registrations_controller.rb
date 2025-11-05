class Api::V1::RegistrationsController < Devise::RegistrationsController
  skip_before_action :authenticate_user

  def create
    @user = User.new user_params

    if @user.save!
      token = JwtService.encode(user_uuid: @user.id)
      message = { messages: "Sign Up Successfully", status: :ok, token: token }
      render json: UserSerializer.new(@user, meta: message)
    else
      render json: { messages: "Sign Up Failed", status: :unprocessable_entity }
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password)
  end
end
