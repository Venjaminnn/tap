# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'POST #create' do
    context 'when logged in successfully' do
      let(:user) { create(:user) }

      it 'login user by email and password' do
        post :create, params: { email: user.email, password: user.password }

        expect(response.body).to eq('Successfully logged')
      end

      it 'login user by phone and password' do
        post :create, params: { phone: user.phone, password: user.password }

        expect(response.body).to eq('Successfully logged')
      end

      context 'when logged in failed' do
        it 'did not login user' do
          post :create, params: { email: 'concon@gmail.com', password: 'wrongpassword' }

          expect(response.body).to eq('Wrong email/phone or password')
        end
      end
    end
  end
end
