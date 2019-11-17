class Api::V1::UsersController < ApplicationController
  before_action :user_params, only: %i[create sign_in change_password]
  before_action :user_params_for_update, only: %i[update]
  before_action :set_user_by_login, only: %i[sign_in]
  before_action :set_user_by_id, only: %i[change_password update]

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
    if @user && valid_password?
      render json: { success: true, errors: {}, result: { token: @user.token } }
    else
      render json: { success: false, errors: { authorization: 'Wrong login or password'}, result: {} }
    end
  end

  def change_password
    if @user && valid_token? && valid_password? && user_params[:confirm_new_password] == user_params[:new_password]
      @user.password = user_params[:new_password]
      generate_user_token
      render json: { success: true, errors: {}, result: { token: @user.token } }
    else
      render json: { success: false, errors: { change_password: 'Something went wrong, check the entered data'}, result: {} }
    end
  end

  def update
    if @user
      @user.update(user_params_for_update)
      render json: { success: true, errors: {}, result: { token: @user.token } }
    else
      render json: { success: false, errors: { user: "User with #{params[:id]} not found"}, result: {} }
    end
  end
  
  private

  def generate_user_token
    @user.token = GenerateTokenService.generate(@user)
    @user.save!
  end

  def valid_token?
    @user.token == user_params[:token]
  end

  def valid_password?
    @user.password == user_params[:password]
  end

  def user_params
    params.permit(:login, :email, :password,
                  :confirm_password, :first_name,
                  :middle_name, :last_name, :birthday,
                  :token, :new_password, :confirm_new_password )
  end

  def user_params_for_update
    params.permit(:first_name, :middle_name, :last_name,
                  :email, :birthday)
  end

  def set_user_by_id
    @user = User.find(params[:id])
  end

  def set_user_by_login
    @user = User.find_by_login(user_params[:login])
  end
end
