# frozen_string_literal: true

class UsersController < ApplicationController
  def create
    user = User.create(registration_params)

    respond_to do |format|
      if user.valid?
        format.html { redirect_to(root_path, notice: 'Successfully registered - login now') }
        format.json { render json: user }
      else
        format.html { redirect_to(root_path, notice: "Registration unsuccessfully: #{user.errors.messages}") }
      end
    end
  end

  def index
    respond_to do |format|
      if logged? && params[:search].present?
        @users = User.search(params[:search], current_user)
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
    params.permit(:phone, :password, :email).merge(nickname_normalize)
  end

  def nickname_normalize
    params.permit(:nickname)
  end
end
