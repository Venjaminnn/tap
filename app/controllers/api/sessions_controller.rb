# frozen_string_literal: true

module Api
  class SessionsController < ApplicationController
    def create
      user = User.find_by(email: params[:email], password: params[:password]) ||
            User.find_by(phone: params[:phone], password: params[:password])

      if user.present?
        session[:user_id] = user.id

        render json: 'User is successfully logged'
      else
        render json: 'Wrong email/phone or password'
      end
    end

    def destroy
      if logged?
        session.delete(:user_id)
        @current_user = nil

        render json: 'User is successfully logged out'
      else
        render json: 'User was not logged before'
      end
    end
  end
end