class Api::V1::SessionsController < ApplicationController
  # skip_before_action :authenticate_user, only: [:create], :raise => false
  skip_before_action :verify_authenticity_token

  # Login (Generate JWT)
  def create
    user = User.find_by(email: params[:email])
    # if user&.authenticate(params[:password])
    if user && user.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      render json: { message: "Logged In Successfully",user: user, token: token }, status: :ok
    else
      render json: { error: "Invalid credentials" }, status: :unauthorized
    end
  end

  # Logout
  def destroy
    render json: { message: "User Logged Out Successfully." }, status: :ok 
  end

  # private

  # def user_params
  #   params.require(:user).permit(:email, :password)
  # end
end
