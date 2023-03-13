# frozen_string_literal: true

class FollowsController < ApplicationController
  before_action :check_login!

  def create
    follow = UserFollow.find_or_initialize_by(follow_params)

    respond_to do |format|
      if follow.save
        format.html { redirect_to(user_path(@current_user.id), notice: 'Successfully followed') }
      else
        format.html { redirect_to(users_path(search: params[:search]), notice: "Can not create follow: #{follow.errors.messages}" ) }
      end
    end
  end

  def destroy
    follow = UserFollow.find_by(destroy_params)

    respond_to do |format|
      if follow
        follow.destroy
        format.html { redirect_to(user_path(@current_user.id), notice: 'Successfully unfollowed') }
      else
        format.html { redirect_to(user_path(@current_user.id), notice: 'Can not find follow') }
      end
    end
  end

  private

  def follow_params
    { following_id: create_params[:following_id], follower_id: current_user.id }
  end

  def create_params
    params.permit(:following_id)
  end

  def destroy_params
    { following_id: params[:following_id], follower_id: current_user.id }
  end
end
