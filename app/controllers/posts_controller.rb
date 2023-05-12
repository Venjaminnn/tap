# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :check_login!

  def new; end

  def create
    post = Post.create(post_params)

    respond_to do |format|
      if post.save
        format.html { redirect_to(feed_url, notice: 'Post successfully created') }
        format.json { render json: post }
      else
        format.html { redirect_to(feed_url, notice: "Something went wrong: #{post.errors.messages}") }
        format.json { render json: post.errors }
      end
    end
  end

  def edit
    @post = current_user.posts.find_by(id: params[:post_id])

    render :edit
  end

  def update
    post = current_user.posts.find_by(id: params[:id])

    respond_to do |format|
      if post
        post.update(update_params)

        format.html { redirect_to(feed_url, notice: 'Post successfully updated') }
        format.json { render json: post }
      else
        format.html { redirect_to(post_edit_path(:post_id), notice: 'Cant find this post user') }
        format.json { render json: 'Can\'t find this post for user' }
      end
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
