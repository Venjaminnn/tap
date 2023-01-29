# frozen_string_literal: true

class UsersController < ApplicationController
  def create
    user = User.create(registration_params)

    respond_to do |format|
      if user.valid?
        format.html { redirect_to(sign_up_url, notice: 'Successfully registered - login now') }

      else
        format.html { redirect_to(sign_up_url, notice: "Registration unsuccessfully: #{user.errors.messages}") }
      end
    end
  end

  private

  def registration_params
    params.permit(:nickname, :phone, :password, :email)
  end
end
