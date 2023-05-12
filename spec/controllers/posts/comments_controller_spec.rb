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

      it 'create comment from current user for JSON format' do
        post :create, params: params, format: :json

        expect(JSON.parse(response.body).symbolize_keys).to include(text: 'my new comment',
                                                                    user_id: user.id,
                                                                    post_id: current_post.id)
      end

      it 'create comment from current user for HTML format' do
        post :create, params: params, format: :html

        expect(response).to be_truthy
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

      it 'create comment from current user for JSON format' do
        post :create, params: params, format: :json
        
        expect(JSON.parse(response.body).symbolize_keys).to eq(text: ['can\'t be blank'])
      end

      it 'create comment from current user for HTML format' do
        post :create, params: params, format: :html

        expect(response).to be_truthy
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

      it 'user is not logged for JSON format' do
        post :create, params: params, format: :json

        expect(response.body).to eq('User is not logged')
      end

      it 'user is not logged for HTML format' do
        post :create, params: params, format: :html

        expect(response).to be_truthy
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

      it 'shows all comments of a post for JSON format' do
        get :index, params: params, format: :json

        expect(JSON.parse(response.body).size).to eq(3)
      end

      it 'shows all comments of a post for HTML format' do
        get :index, params: params, format: :html

        expect(response).to be_truthy
      end
    end

    context 'when post do not have any comment' do
      it 'do not show any comment for JSON format' do
        get :index, params: params, format: :json

        expect(JSON.parse(response.body).size).to eq(0)
      end

      it 'do not show any comment for HTML format' do
        get :index, params: params, format: :html

        expect(response).to be_truthy
      end
    end

    context 'when post does not exist' do
      let(:params) do
        {
          post_id: 0
        }
      end

      it 'shows an error for JSON format' do
        get :index, params: params, format: :json

        expect(response.body).to eq('Error: Post not found')
      end

      it 'shows an error for HTML format' do
        get :index, params: params, format: :html

        expect(response).to be_truthy
      end
    end

    context 'when current user is not setted' do
      before do
        session[:user_id] = nil
      end

      it 'shows an error for JSON format' do
        get :index, params: params, format: :json

        expect(response.body).to eq('User is not logged')
      end

      it 'shows an error for HTML format' do
        get :index, params: params, format: :html

        expect(response).to be_truthy
      end
    end
  end

  describe 'GET #destroy' do
    let(:comment) { create(:comment, user: user) }

    before do
      session[:user_id] = user.id
    end

    context 'when comment successfully deleted' do
      it 'successfully deleted comment for JSON format' do
        get 'destroy', params: { post_id: current_post.id, comment_id: comment.id }, format: :json

        expect(response.body).to eq('Comment successfully deleted')
      end

      it 'successfully deleted comment for HTML format' do
        get 'destroy', params: { post_id: current_post.id, comment_id: comment.id }, format: :html

        expect(response).to be_truthy
      end
    end

    context 'when deleting comment is failed' do
      it 'deleting is failed for JSON format' do
        get :destroy, params: { post_id: current_post.id, comment_id: 0 }, format: :json

        expect(response.body).to eq('Error: Can not find comment')
      end

        it 'deleting is failed for HTML format' do
          get :destroy, params: { post_id: current_post.id, comment_id: 0 }, format: :html
  
          expect(response).to be_truthy
      end
    end
  end
end
