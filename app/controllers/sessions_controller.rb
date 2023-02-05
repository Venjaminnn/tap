# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.third

    respond_to do |format|
      if user.valid?
        format.html { redirect_to(feed_url, notice: 'Successfully logged') }
      else
        format.html { redirect_to(sign_up_url, notice: "Registration unsuccessfully: #{user.errors.messages}") }
      end
    end
  end

  def destroy
    if logged?
      session.delete(:user_id)
      @current_user = nil

      render json: 'Successfully logged out'
    else
      render json: 'User was not logged before'
    end
  end
end
