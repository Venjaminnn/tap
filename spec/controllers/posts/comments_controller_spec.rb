# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Posts::CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:current_post) { create(:post, user: user) }

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
