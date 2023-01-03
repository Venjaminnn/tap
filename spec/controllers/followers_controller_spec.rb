# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FollowersController, type: :controller do
  describe 'POST #create' do
    before do
      session[:user_id] = follower.id
    end

    let(:follower) { create(:user) }

    context 'when creating follow' do
      let(:following) { create(:user) }
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
end
