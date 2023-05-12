# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FollowsController, type: :controller do
  let(:follower) { create(:user) }
  let(:following) { create(:user) }

  describe 'POST #create' do
    before do
      session[:user_id] = follower.id
    end

    context 'when creating follow' do
      let(:params) { { following_id: following.id } }
      let(:output_params) { { following_id: following.id, follower_id: follower.id } }

      it 'creates follow for JSON format' do
        post :create, params: params, format: :json

        expect(JSON.parse(response.body)).to include(output_params.stringify_keys)
      end
      
      it 'creates follow for HTML format' do
        post :create, params: params, format: :html

        expect(response).to be_truthy
      end
    end

    context 'when creating follow failed' do
      let(:params) { { following_id: nil } }

      it 'is not creates follow for JSON format' do
        post :create, params: params, format: :json

        expect(JSON.parse(response.body)).to eq('following' => ['must exist'])
      end
      
      it 'is not creates follow for HTML format' do
        post :create, params: params, format: :html

        expect(response).to be_truthy
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      session[:user_id] = follower.id
    end

    context 'when successfully destroy follow' do
      let!(:user_follow) { create(:user_follow, following: following, follower: follower) }

      it 'Successfully unfollowed for JSON format' do
        delete :destroy, params: { following_id: following.id }, format: :json

        expect(response.body).to eq('Successfully unfollowed')
      end
      
      it 'Successfully unfollowed for HTML format' do
        delete :destroy, params: { following_id: following.id }, format: :html

        expect(response).to be_truthy
      end
    end

    context 'when destroy follow failed' do
      it 'Unfollowed is failed for JSON format' do
        delete :destroy, params: { following_id: following.id }, format: :json

        expect(response.body).to eq('Error: Can not find follow')
      end
      
      it 'Unfollowed is failed for HTML format' do
        delete :destroy, params: { following_id: following.id }, format: :html

        expect(response).to be_truthy
      end
    end
  end
end

