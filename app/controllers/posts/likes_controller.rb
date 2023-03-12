# frozen_string_literal: true

module Posts
  class LikesController < ApplicationController
    before_action :check_login!

    def create
      respond_to do |format|
        if post
          like_transaction
          format.html { redirect_to(feed_path, notice: 'Post successfully liked') }
        else
          format.html { redirect_to(feed_url, notice: 'Error: Post not find') }
        end
      end
    end

    def destroy
      respond_to do |format|
        if post && like
          dislike_transaction
          format.html { redirect_to(feed_url, notice: 'Dislike successfully created') }
        else
          format.html { redirect_to(feed_url, notice: 'Error: Post or like is not founded') }
        end
      end
    end

    def index
      post = Post.find_by(id: params[:post_id])

      if post
        render json: post.likes
      else
        render json: 'Post not found', status: :not_found
      end
    end

    private

    def post
      @post ||= Post.find_by(id: params[:post_id])
    end

    def like_transaction
      Post.transaction do
        post.likes.create!(user: current_user)
        post.like
      end
    end

    def dislike_transaction
      Post.transaction do
        like.destroy
        post.dislike
      end
    end

    def like
      @like ||= post.likes.find_by(user: current_user)
    end
  end
end
