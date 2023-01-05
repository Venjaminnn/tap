# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :check_login!

  def create
    comment = Comment.create(comment_params)

    if comment.valid?
      render json: comment
    else
      render json: comment.errors
    end
  end

  def destroy
    comment = current_user.comments.find_by(id: params[:id])

    if comment
      comment.destroy
      render json: 'Comment successfully deleted'
    else
      render json: 'Error: Can not find comment', status: :not_found
    end
  end

  private

  def comment_params
    params.permit(:text, :post_id).merge(user_id: current_user.id)
  end
end
