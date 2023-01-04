# frozen_string_literal: true

class FeedsController < ApplicationController
  before_action :check_login!

  def index
    feed_posts = user_posts.or(following_posts).order(created_at: :desc)

    render json: feed_posts
  end

  private

  def following_ids
    UserFollow.where(follower_id: current_user.id).pluck(:following_id)
  end

  def user_posts
    current_user.posts
  end

  def following_posts
    Post.where(user_id: following_ids)
  end
end
