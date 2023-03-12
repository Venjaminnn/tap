# frozen_string_literal: true

class UsersController < ApplicationController
  def create
    user = User.create(registration_params)

    respond_to do |format|
      if user.valid?
        format.html { redirect_to(root_path, notice: 'Successfully registered - login now') }
      else
        format.html { redirect_to(root_path, notice: "Registration unsuccessfully: #{user.errors.messages}") }
      end
    end
  end

  def index
    respond_to do |format|
      if logged? && params[:search].present?
        @users = User.search(params[:search])
        format.html { render 'users/index'}
      else
        format.html {redirect_to(feed_path)}
      end
    end
  end

  def show
    respond_to do |format|
      if logged?
        format.html { render 'users/show'}
      else
        format.html { redirect_to(root_path, notice: 'User is not logged') }
      end
    end
  end

  private

  def registration_params
    params.permit(:nickname, :phone, :password, :email)
  end
end
