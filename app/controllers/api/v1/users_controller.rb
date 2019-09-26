class Api::V1::UsersController < ApplicationController
  before_action :user_params
  before_action :set_user, only: :update

  def create
    @user = User.new(email: user_params[:email], encrypted_password: user_params[:password],
                     name: user_params[:name])
    if @user.save
      render json: @user, status: :created 
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def set_user
    @user = User.find_by_email(params[:email])
  end
end
