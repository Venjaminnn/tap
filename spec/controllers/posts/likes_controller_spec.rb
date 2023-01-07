# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Posts::LikesController, type: :controller do
  let(:user) { create(:user) }
  let(:current_post) { create(:post, user: user) }

  describe 'POST #create' do
    before do
      session[:user_id] = user.id
    end

    context 'when successfully creating like' do
      let(:params) do
        {
          post_id: current_post.id
        }
      end

      it 'change likes count column' do
        post :create, params: params

        expect(JSON.parse(response.body).symbolize_keys).to include(likes_count: 1)
      end

      it 'create like from current user' do
        expect { post :create, params: params }.to change(Like, :count).by(1)
      end
    end

    context 'when post does not exist' do
      it 'shows an error' do
        post :create, params: { post_id: 0 }

        expect(response.body).to eq('Error: Post not find')
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      session[:user_id] = user.id
    end

    let(:current_post) { create(:post, user: user, likes_count: likes_count) }

    context 'when successfully delete like' do
      let!(:like) { create(:like, post: current_post, user: user) }
      let!(:likes_count) { 1 }

      let(:params) do
        {
          post_id: current_post.id
        }
      end

      it 'change likes count column' do
        post :destroy, params: params

        expect(JSON.parse(response.body).symbolize_keys).to include(likes_count: 0)
      end

      it 'delete like from current user' do
        expect { post :destroy, params: params }.to change(Like, :count).by(-1)
      end
    end

    context 'when post does not exist' do
      let(:likes_count) { 0 }

      it 'shows an error' do
        post :destroy, params: { post_id: 0 }

        expect(response.body).to eq('Error: Post or like is not founded')
      end
    end

    context 'when post do not have like' do
      let(:likes_count) { 0 }

      it 'shows an error' do
        post :destroy, params: { post_id: current_post.id }

        expect(response.body).to eq('Error: Post or like is not founded')
      end
    end
  end

  describe 'GET #index' do
    before do
      session[:user_id] = user.id
    end

    let(:params) do
      {
        post_id: current_post.id
      }
    end

    context 'show all likes of a post' do
      let!(:likes) { create_list(:like, 3, post: current_post) }

      it 'show all likes of a post' do
        get :index, params: params

        expect(JSON.parse(response.body).size).to eq(3)
      end
    end

    context 'when post do not have any like' do
      it 'do not show any like' do
        get :index, params: params

        expect(JSON.parse(response.body).size).to eq(0)
      end
    end
  end
end
