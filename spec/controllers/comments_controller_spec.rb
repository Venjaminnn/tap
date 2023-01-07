# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:current_post) { create(:post, user: user) }

  describe 'DELETE #destroy' do
    let(:comment) { create(:comment, user: user) }

    before do
      session[:user_id] = user.id
    end

    context 'when comment successfully deleted' do
      it 'successfully deleted comment' do
        delete :destroy, params: { id: comment.id }

        expect(response.body).to eq('Comment successfully deleted')
      end
    end

    context 'when deleting comment if failed' do
      it 'deleting is failed' do
        delete :destroy, params: { id: 0 }

        expect(response.body).to eq('Error: Can not find comment')
      end
    end
  end
end
