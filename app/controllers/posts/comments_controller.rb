# frozen_string_literal: true

module Posts
  class CommentsController < ApplicationController
    before_action :check_login!

    def new;
    end

    def create
      comment = Comment.new(comment_params)

      respond_to do |format|
        if comment.save
          format.html { redirect_to(post_comments_path, notice: 'Comment successfully created') }
        else
          format.html { redirect_to(post_comments_url, notice: "Something went wrong: #{comments.errors.messages}") }
        end
      end
    end

    def index
      post = Post.find_by(id: params[:post_id])

      if post.present?
        render json: post.comments
      else
        render json: 'Comments not found', status: :not_found
      end
    end

    def destroy
      comment = current_user.comments.find_by(id: params[:id])
      
      respond_to do |format|
        if comment
          comment.destroy
          format.html { redirect_to(post_comments_path, notice: 'Comment successfully deleted') }
        else
          format.html { redirect_to(feed_url, notice: 'Can not find comment') }
        end
      end
    end

    private

    def post
      Post.find_by(id: params[:post_id])
    end

    def comment_params
      params.permit(:text, :post_id).merge(user_id: current_user.id)
    end
  end
end
