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
          format.html { redirect_to(feed_url, notice: "Something went wrong: #{comment.errors.messages}") }
        end
      end
    end

    def index
      @comments = post.comments

      respond_to do |format|
        if @comments
          format.html { render 'comments/index' }
        else
          format.html { redirect_to(feed_url, notice: 'Post not found') }
        end
      end
    end

    def destroy
      comment = current_user.comments.find_by(id: params[:comment_id])
      
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
