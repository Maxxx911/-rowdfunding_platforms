class Api::V1::UsersController < ApplicationController
  before_action :user_params, only: %i[create sign_in update]
  before_action :set_user_by_email, only: %i[sign_in]
  before_action :set_user_by_id, only: %i[edit update]

  def create
    @user = User.new(email: user_params[:email],
                     name: user_params[:name])
    @user.password = user_params[:password]
    if @user.save
      render json: @user, status: :created 
    else
      render json: {errors: @user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def sign_in
    if @user && @user.password == user_params[:password]
      render json: @user, status: :ok
    else
      render json: {errors: 'Wrong email or password'}, status: :bad_request
    end
  end

  def edit
    if @user.empty?
      render json: {errors: 'User with this id not found' }, status: :bad_request
    else
      render json: @user.first, status: :ok
    end
  end

  def update
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def set_user_by_id
    @user = User.where(id: params[:id])
  end

  def set_user_by_email
    @user = User.find_by_email(user_params[:email])
  end
end
