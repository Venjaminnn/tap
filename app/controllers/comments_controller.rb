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

  private

  def comment_params
    params.permit(:text, :post_id).merge(user_id: current_user.id)
  end
end
