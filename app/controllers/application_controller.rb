# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged?
    current_user.present?
  end

  def check_login!
    return render json: 'User is not logged' unless logged?
  end
end
