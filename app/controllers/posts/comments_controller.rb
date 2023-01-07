# frozen_string_literal: true

module Posts
  class CommentsController < ApplicationController
    before_action :check_login!

    def index
      post = Post.find_by(id: params[:post_id])

      if post.present?
        render json: post.comments
      else
        render json: 'Comments not found', status: :not_found
      end
    end
  end
end
