# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FeedsController, type: :controller do
  let(:current_user) { create(:user) }

  describe 'GET #index' do
    before do
      session[:user_id] = current_user&.id
    end

    context 'when show user and following posts' do
      let!(:user_posts) { create_list(:post, 3, user: current_user) }
      let!(:first_follow) { create(:user_follow, following: first_following, follower: current_user) }
      let(:first_following) { create(:user) }
      let!(:second_follow) { create(:user_follow, following: second_following, follower: current_user) }
      let(:second_following) { create(:user) }
      let!(:first_follow_posts) { create_list(:post, 2, user: first_following) }
      let!(:second_follow_posts) { create_list(:post, 2, user: second_following) }

      it 'shows all posts' do
        get :index

        expect(JSON.parse(response.body).size).to eq(7)
      end
    end

    context 'when show user posts without following' do
      let!(:user_posts) { create_list(:post, 3, user: current_user) }

      it 'shows user posts' do
        get :index

        expect(JSON.parse(response.body).size).to eq(3)
      end
    end

    context 'when show following posts without users' do
      let!(:first_follow) { create(:user_follow, following: first_following, follower: current_user) }
      let(:first_following) { create(:user) }
      let!(:second_follow) { create(:user_follow, following: second_following, follower: current_user) }
      let(:second_following) { create(:user) }
      let!(:first_follow_posts) { create_list(:post, 2, user: first_following) }
      let!(:second_follow_posts) { create_list(:post, 2, user: second_following) }

      it 'shows following posts' do
        get :index

        expect(JSON.parse(response.body).size).to eq(4)
      end
    end

    context 'when do not show any posts' do
      it 'do not show any posts' do
        get :index

        expect(JSON.parse(response.body).size).to eq(0)
      end
    end

    context 'when current user is not setted' do
      let(:current_user) { nil }

      it 'shows an error' do
        get :index

        expect(response.body).to eq('User is not logged')
      end
    end
  end
end
