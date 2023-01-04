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

      it 'creates follow' do
        post :create, params: params

        expect(JSON.parse(response.body)).to include(output_params.stringify_keys)
      end
    end

    context 'when creating follow failed' do
      let(:params) { { following_id: nil } }

      it 'is not creates follow' do
        post :create, params: params

        expect(JSON.parse(response.body)).to eq('following' => ['must exist'])
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      session[:user_id] = follower.id
    end

    context 'when successfully destroy follow' do
      let!(:user_follow) { create(:user_follow, following: following, follower: follower) }

      it 'Successfully unfollowed' do
        delete :destroy, params: { id: following.id }

        expect(response.body).to eq('Successfully unfollowed')
      end
    end

    context 'when destroy follow failed' do
      it 'Unfollowed is failed' do
        delete :destroy, params: { id: following.id }

        expect(response.body).to eq('Error: Can not find follow')
      end
    end
  end
end
