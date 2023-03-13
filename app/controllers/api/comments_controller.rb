# frozen_string_literal: true

module Api
  class CommentsController < ApplicationController
    before_action :check_login!

    def destroy
      comment = current_user.comments.find_by(id: params[:id])

      if comment
        comment.destroy
        render json: 'Comment successfully deleted'
      else
        render json: 'Error: Can not find comment', status: :not_found
      end
    end
  end
end
