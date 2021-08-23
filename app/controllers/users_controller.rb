class UsersController < ApplicationController
  before_action :set_user, only: [:update]
  before_action :check_owner, only: [:update]
  def create
    @user = User.new(user_params)

    if @user.save
      render json: { id: @user.id, username: @user.username }, status: 201
    else
      render json: @user.errors, status: 400
    end
  end

  def update
    user_params.each do |key, value|
      @user.update_attribute(key, value)
    end
    render json: { id: @user.id, username: @user.username }, status: 202
  rescue StandardError => e
    render json: @user.errors, status: 400
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def check_owner
    head :forbidden unless @user.id == current_user&.id
  end
end
