# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Posts::CommentsController, type: :controller do
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

  describe 'GET #index' do
    before do
      session[:user_id] = user.id
    end

    let(:params) do
      {
        post_id: current_post.id
      }
    end

    context 'when opened all comments of a post' do
      let!(:comments) { create_list(:comment, 3, post: current_post) }

      it 'shows all comments of a post' do
        get :index, params: params

        expect(JSON.parse(response.body).size).to eq(3)
      end
    end

    context 'when post do not have any comment' do
      it 'do not show any comment' do
        get :index, params: params

        expect(JSON.parse(response.body).size).to eq(0)
      end
    end

    context 'when post does not exist' do
      let(:params) do
        {
          post_id: 0
        }
      end

      it 'shows an error' do
        get :index, params: params

        expect(response.body).to eq('Error: Post not found')
      end
    end

    context 'when current user is not setted' do
      before do
        session[:user_id] = nil
      end

      it 'shows an error' do
        get :index, params: params

        expect(response.body).to eq('User is not logged')
      end
    end
  end
end
