# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :check_login!

  def create
    post = Post.create(post_params)

    if post.valid?
      render json: post
    else
      render json: post.errors
    end
  end

  private

  def post_params
    params.permit(:image, :comment).merge(user_id: current_user.id)
  end
end
