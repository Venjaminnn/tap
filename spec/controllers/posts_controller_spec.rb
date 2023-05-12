# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create(:user) }
  describe 'POST #create' do
    context 'when successfully creating post' do
      let(:image) { fixture_file_upload('image.jpg', 'image/jpg') }

      let(:params) do
        {
          comment: 'my new post',
          image: image
        }
      end

      before do
        session[:user_id] = user.id

        post :create, params: params
      end

      it 'create post from current user for JSON format' do
        post :create, format: :json, params: params

        expect(JSON.parse(response.body).symbolize_keys).to include(comment: 'my new post',
                                                                    user_id: user.id,
                                                                    likes_count: 0)
      end

      it 'create post from current user for HTML format' do
        post :create, format: :html, params: params

        expect(response).to be_truthy
      end

      it 'create post from current user and attach image for JSON format' do
        post :create, format: :json
        
        expect(Post.last.image).to be_present
      end

      it 'create post from current user and attach image for HTML format' do
        post :create, format: :html

        expect(Post.last.image).to be_present
      end
    end

    context 'when not creating post' do
      before do
        session[:user_id] = user.id

        post :create, params: params
      end

      let(:params) do
        {
          comment: 'my new post'
        }
      end

      it 'create post from current user and attach image for JSON format' do
        post :create, format: :json

        expect(JSON.parse(response.body).symbolize_keys).to eq(image: ['can\'t be blank'])
      end

      it 'create post from current user and attach image for HTML format' do
        post :create, format: :html

        expect(response).to be_truthy
      end
    end

    context 'when trying to create post without log in' do
      let(:params) do
        {
          comment: 'my new post'
        }
      end

      it 'did not login user for JSON format' do
        post :create, params: params, format: :json

        expect(response.body).to eq('User is not logged')
      end

      it 'did not login user for HTML format' do
        post :create, params: params, format: :html

        expect(response).to be_truthy
      end
    end
  end

  describe 'PATCH #update' do
    context 'when successfully update post' do
      let(:post) { create(:post, user: user) }

      let(:params) do
        {
          comment: 'my new post'
        }
      end

      before do
        session[:user_id] = user.id

        patch :update, params: { id: post.id, comment: 'updated comment' }
      end

      it 'update post from current user for JSON format' do
        patch :update, format: :json, params: { id: post.id, comment: 'updated comment' }

        expect(JSON.parse(response.body).symbolize_keys).to include(comment: 'updated comment')
      end

      it 'update post from current user for HTML format' do
        patch :update, format: :html, params: { id: post.id, comment: 'updated comment' }

        expect(response).to be_truthy
      end
    end

    context 'when failed to update post' do
      let(:post) { create(:post) }

      let(:params) do
        {
          comment: 'my new post'
        }
      end

      before do
        session[:user_id] = user.id

        patch :update, params: { id: post.id, comment: 'updated comment' }
      end

      it 'create post from current user for JSON format' do
        patch :update, format: :json, params: { id: post.id, comment: 'updated comment' }

        expect(response.body).to eq('Can\'t find this post for user')
      end

      it 'create post from current user for HTML format' do
        patch :update, format: :html, params: { id: post.id, comment: 'updated comment' }

        expect(response).to be_truthy
      end
    end

    context 'when trying to update post without log in' do
      let(:post) { create(:post) }
      let(:params) do
        {
          comment: 'my new post'
        }
      end

      it 'did not login user for JSON format' do
        patch :update, format: :json, params: { id: post.id, comment: 'updated comment' }

        expect(response.body).to eq('User is not logged')
      end

      it 'did not login user for HTML format' do
        patch :update, format: :html, params: { id: post.id, comment: 'updated comment' }

        expect(response).to be_truthy
      end
    end
  end
end
