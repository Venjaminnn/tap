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

  def update
    post = current_user.posts.find_by(id: params[:id])

    if post
      post.update(update_params)

      render json: post
    else
      render json: 'Can\'t find this post for user'
    end
  end

  private

  def update_params
    params.permit(:comment)
  end

  def post_params
    params.permit(:image, :comment).merge(user_id: current_user.id)
  end
end
