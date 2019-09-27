class Api::V1::UsersController < ApplicationController
  before_action :user_params
  before_action :set_user_by_email, only: %i[sign_in]

  def create
    @user = User.new(email: user_params[:email],
                     name: user_params[:name])
    @user.password = user_params[:password]
    if @user.save
      render json: @user, status: :created 
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def sign_in
    if @user.password == user_params[:password]
      render json: @user, status: :ok
    else
      render json: ['Wrong email or password']
    end
  end

  def edit
  end

  def update
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def set_user_by_email
    @user = User.find_by_email(params[:email])
  end
end
