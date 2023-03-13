# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::SessionsController, type: :controller do
  let(:user) { create(:user) }
  describe 'POST #create' do
    context 'when logged in successfully' do
      it 'login user by email and password' do
        post :create, params: { email: user.email, password: user.password }

        expect(response.body).to eq('User is successfully logged')
      end

      it 'login user by phone and password' do
        post :create, params: { phone: user.phone, password: user.password }

        expect(response.body).to eq('User is successfully logged')
      end

      context 'when logged in failed' do
        it 'did not login user' do
          post :create, params: { email: 'concon@gmail.com', password: 'wrongpassword' }

          expect(response.body).to eq('Wrong email/phone or password')
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when user is logged out' do
      before do
        session[:user_id] = user.id
      end

      it 'successfully logged out user' do
        delete :destroy

        expect(response.body).to eq('User is successfully logged out')
      end
    end

    context 'when user was not logged in' do
      it 'can not logged out user' do
        delete :destroy

        expect(response.body).to eq('User was not logged before')
      end
    end
  end
end
