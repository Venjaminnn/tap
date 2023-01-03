# frozen_string_literal: true

class FollowersController < ApplicationController
  def create
    follow = UserFollow.new(follow_params)

    if follow.save
      render json: follow
    else
      render json: follow.errors
    end
  end

  private

  def follow_params
    { following_id: create_params[:following_id], follower_id: current_user.id }
  end

  def create_params
    params.permit(:following_id)
  end
end
