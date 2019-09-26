class UsersController < ApplicationController
  before_action :user_params
  before_action :set_user, only: :update

  def create
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
