# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.first || User.find_by(email: params[:email], password: params[:password]) ||
      User.find_by(phone: params[:phone], password: params[:password])

    respond_to do |format|
      if user.present?
        session[:user_id] = user.id
        format.html { redirect_to(feed_url, notice: 'User is successfully logged') }
      else
        format.html { redirect_to(sign_up_url, notice: "Registration unsuccessfully: #{user.errors.messages}") }
      end
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