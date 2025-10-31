class Api::V1::RegistrationsController < Devise::RegistrationsController
  skip_before_action :authenticate_user

  def create
    @user = User.new user_params
    token = JwtService.encode(user_id: @user.id)

    if @user.save!
      message = { messages: "Sign Up Successfully", status: :ok, token: token }
      render json: UserSerializer.new( meta: message , @user)
    else
      render json: { messages: "Sign Up Failed", status: :unprocessable_entity }
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :name, :password)
  end
end