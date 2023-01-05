# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:current_post) { create(:post, user: user) }

  describe 'POST #create' do
    context 'when successfully creating comment' do
      let(:text) { 'one random comment' }

      let(:params) do
        {
          text: 'my new comment',
          post_id: current_post.id
        }
      end

      before do
        session[:user_id] = user.id
      end

      it 'create comment from current user' do
        post :create, params: params

        expect(JSON.parse(response.body).symbolize_keys).to include(text: 'my new comment',
                                                                    user_id: user.id,
                                                                    post_id: current_post.id)
      end
    end

    context 'when creating comment failed' do
      before do
        session[:user_id] = user.id

        post :create, params: params
      end

      let(:params) do
        {
          post_id: current_post.id
        }
      end

      it 'create comment from current user' do
        expect(JSON.parse(response.body).symbolize_keys).to eq(text: ['can\'t be blank'])
      end
    end

    context 'when trying to create comment without log in' do
      before do
        session[:user_id] = nil

        post :create, params: params
      end

      let(:params) do
        {
          text: 'my new comment',
          post_id: current_post.id
        }
      end

      it 'user is not logged' do
        post :create, params: params

        expect(response.body).to eq('User is not logged')
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:comment) { create(:comment, user: user) }

    before do
      session[:user_id] = user.id
    end

    context 'when comment successfully deleted' do
      it 'successfully deleted comment' do
        delete :destroy, params: { id: comment.id }

        expect(response.body).to eq('Comment successfully deleted')
      end
    end

    context 'when deleting comment if failed' do
      it 'deleting is failed' do
        delete :destroy, params: { id: 0 }

        expect(response.body).to eq('Error: Can not find comment')
      end
    end
  end
end
