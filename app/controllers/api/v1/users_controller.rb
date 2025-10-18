class Api::V1::UsersController < ApplicationController
  # skip_before_action :authenticate_user, only: :create, :raise => false
  # skip_before_action :verify_authenticity_token
  # before_action :set_user, only: [:show, :update, :destroy]
  # rescue_from ::CatchAll, with: :all_exception

  # def index
  # end

  #User SignUp
  # def create
  #   # debugger
  #   user = User.new(user_params)

  #   if user.save!
  #     token = JsonWebToken.encode(user_id: user.id)
  #     render json: { token: token, user: user }, status: :created
  #   else
  #     render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
  #   end
  # end

  # def show
  #   render json: @user, serializer: UsersSerializer, status: :ok
  # end

  # def update
  #   if @user.update(user_params)
  #     render json: @user, serializer: UsersSerializer, status: :ok
  #   else
  #     render json: { message: @user.errors.full_messages }, status: :not_found
  #   end
  # end

  # def destroy
  #   if @user.destroy
  #     render json: { message: "User Deleted Successfully." }, status: :ok
  #   else
  #     render json: { message: @user.errors.full_messages }, status: :not_found
  #   end
  # end

  # private

  # def user_params
  #   params.require(:user).permit(:username, :email, :password)
  # end

  # def set_user
  #   # begin
  #   @user = User.find(params[:id])
  #   # @user.lll
  #   rescue ActiveRecord::RecordNotFound
  #     render json: { message: "User not found." }, status: :not_found
  # end

  # # def all_exception
  #   render json: { message: "Undefined Error" }, status: 500
  # end

end
