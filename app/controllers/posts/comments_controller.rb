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
          format.json { render json: comment }
        else
          format.html { redirect_to(feed_url, notice: "Something went wrong: #{comment.errors.messages}") }
          format.json { render json: comment.errors }
        end
      end
    end

    def index
      @post = post

      respond_to do |format|
        if @post
          @comments = @post.comments
          format.html { render 'comments/index' }
          format.json { render json: @comments }
        else
          format.html { redirect_to(feed_url, notice: 'Post not found') }
          format.json { render json: 'Error: Post not found', status: :not_found }
        end
      end
    end

    def destroy
      comment = current_user.comments.find_by(id: params[:comment_id])
          
      respond_to do |format|
        if comment
          comment.destroy
          format.html { redirect_to(post_comments_path, notice: 'Comment successfully deleted') }
          format.json { render json: 'Comment successfully deleted' }
        else
          format.html { redirect_to(feed_url, notice: 'Can not find comment') }
          format.json { render json: 'Error: Can not find comment', status: :not_found }
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
