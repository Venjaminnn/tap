# frozen_string_literal: true

module Api
  class FollowsController < ApplicationController
    before_action :check_login!

    def create
      follow = UserFollow.new(follow_params)

      if follow.save
        render json: follow
      else
        render json: follow.errors
      end
    end

    def destroy
      follow = UserFollow.find_by(destroy_params)

      if follow
        follow.destroy
        render json: 'Successfully unfollowed'
      else
        render json: 'Error: Can not find follow'
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
end
