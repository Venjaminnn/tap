class UsersController < ApplicationController
  def create
    user = User.create(registration_params)

    render json: user
  end

  private

  def registration_params
    params.permit(:nickname, :phone, :password, :email)
  end
end