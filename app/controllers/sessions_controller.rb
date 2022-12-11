# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email], password: params[:password]) ||
           User.find_by(phone: params[:phone], password: params[:password])

    if user.present?
      session[:user_id] = user.id

      render json: 'Successfully logged'
    else
      render json: 'Wrong email/phone or password'
    end
  end

  private

  def registration_params
    params.permit(:nickname, :phone, :password, :email)
  end
end
