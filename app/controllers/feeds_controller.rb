# frozen_string_literal: true

class FeedsController < ApplicationController
  before_action :set_active_storage_host
  before_action :check_login!

  def index
    @feed_posts = user_posts.or(following_posts).order(created_at: :desc)

    respond_to do |format|
      if @feed_posts
        format.html { render template: 'feed/index' }
        format.json { render json: @feed_posts }
      else
        format.html { redirect_to(sign_up_url, notice: "Login unsuccessfully: #{user.errors.messages}") }
      end
    end
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

  def set_active_storage_host
    ActiveStorage::Current.host = request.base_url
  end
end
