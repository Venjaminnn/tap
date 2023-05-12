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

      it 'shows all posts for JSON format' do
        get :index, format: :json

        expect(JSON.parse(response.body).size).to eq(7)
      end
      
      it 'shows all posts for HTML format' do
        get :index, format: :html

        expect(response).to be_successful
      end

    render_views
      it 'render edit button for user posts' do
        get :index, format: :html

        expect(response.body).to include(post_edit_path(user_posts.first.id))
      end

      it 'not render edit button for another user posts' do
        get :index, format: :html

        expect(response.body).to_not include(post_edit_path(second_follow_posts.first.id))
      end
    end

    context 'when show user posts without following' do
      let!(:user_posts) { create_list(:post, 3, user: current_user) }

      it 'shows user posts for JSON format' do
        get :index, format: :json

        expect(JSON.parse(response.body).size).to eq(3)
      end
      
      it 'shows user posts for HTML format' do
        get :index, format: :html

        expect(response).to be_successful
      end
    end

    context 'when show following posts without users' do
      let!(:first_follow) { create(:user_follow, following: first_following, follower: current_user) }
      let(:first_following) { create(:user) }
      let!(:second_follow) { create(:user_follow, following: second_following, follower: current_user) }
      let(:second_following) { create(:user) }
      let!(:first_follow_posts) { create_list(:post, 2, user: first_following) }
      let!(:second_follow_posts) { create_list(:post, 2, user: second_following) }

      it 'shows following posts for JSON format' do
        get :index, format: :json

        expect(JSON.parse(response.body).size).to eq(4)
      end
      
      it 'shows following posts for HTML format' do
        get :index, format: :html
        
        expect(response).to be_successful
      end
    end

    context 'when do not show any posts' do
      it 'do not show any posts for JSON format' do
        get :index, format: :json

        expect(JSON.parse(response.body).size).to eq(0)
      end
      
      it 'do not show any posts for HTML format' do
        get :index, format: :html

        expect(response).to be_successful
      end
    end

    context 'when current user is not setted' do
      let(:current_user) { nil }

      it 'shows an error for JSON format' do
        get :index, format: :json

        expect(response.body).to eq('User is not logged')
      end
      
      it 'shows an error for HTML format' do
        get :index, format: :html

        expect(response).to be_successful
      end 
    end
  end
end
