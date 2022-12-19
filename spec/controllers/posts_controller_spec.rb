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

      it 'create post from current user' do
        expect(JSON.parse(response.body).symbolize_keys).to include(comment: 'my new post',
                                                                    user_id: user.id,
                                                                    likes_count: 0)
      end

      it 'create post from current user and attach image' do
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

      it 'create post from current user and attach image' do
        expect(JSON.parse(response.body).symbolize_keys).to eq(image: ['can\'t be blank'])
      end
    end

    context 'when trying to create post without log in' do
      let(:params) do
        {
          comment: 'my new post'
        }
      end

      it 'did not login user' do
        post :create, params: params

        expect(response.body).to eq('User is not logged')
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

      it 'update post from current user' do
        expect(JSON.parse(response.body).symbolize_keys).to include(comment: 'updated comment')
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

      it 'create post from current user' do
        expect(response.body).to eq('Can\'t find this post for user')
      end
    end

    context 'when trying to uodate post without log in' do
      let(:post) { create(:post) }
      let(:params) do
        {
          comment: 'my new post'
        }
      end

      it 'did not login user' do
        patch :update, params: { id: post.id, comment: 'updated comment' }

        expect(response.body).to eq('User is not logged')
      end
    end
  end
end
