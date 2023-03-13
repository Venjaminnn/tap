# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email], password: params[:password]) ||
      User.find_by(phone: params[:phone], password: params[:password])

    respond_to do |format|
      if user.present?
        session[:user_id] = user.id
        format.html { redirect_to(feed_url, notice: 'User is successfully logged') }
      else
        format.html { redirect_to(root_path, notice: 'Registration unsuccessfully') }
      end
    end
  end

  def destroy

    respond_to do |format|
      if logged?
        session.delete(:user_id)
        @current_user = nil

        format.html { redirect_to(root_path, notice: 'User is successfully logged out') }
      else
        format.html { redirect_to(root_path, notice: 'User was not logged before') }
      end
    end
  end
end