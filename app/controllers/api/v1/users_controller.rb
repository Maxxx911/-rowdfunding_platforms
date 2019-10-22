class Api::V1::UsersController < ApplicationController
  before_action :user_params, only: %i[create sign_in]
  before_action :user_params_for_update, only: %i[update]
  before_action :set_user_by_email, only: %i[sign_in]
  before_action :set_user_by_id, only: %i[edit update]

  def create
    @user = User.new(email: user_params[:email],
                     login: user_params[:login],
                     birthday: user_params[:birthday],
                     first_name: user_params[:first_name],
                     middle_name: user_params[:middle_name],
                     last_name: user_params[:last_name])
    @user.password = user_params[:password]
    if @user.save
      generate_user_token
      render json: { success: true, errors: {}, result: { token: @user.token } }
    else
      render json: { success: false, errors: @user.errors.messages, result: {} }
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
    if @user.empty?
      render json: {errors: 'User with this id not found' }, status: :bad_request
    else
      @user.update(user_params_for_update)
      render json: @user, status: :ok
    end
  end

  private

  def generate_user_token
    @user.token = GenerateTokenService.generate(@user)
    @user.save!
  end

  def user_params_for_update
    params.require(:user).permit(:name)
  end

  def user_params
    params.permit(:login, :email, :password,
                  :confirm_password, :first_name,
                  :middle_name, :last_name, :birthday)
  end

  def set_user_by_id
    @user = User.where(id: params[:id])
  end

  def set_user_by_email
    @user = User.find_by_email(user_params[:email])
  end
end
