# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user) { create(:user) }
  describe 'POST #create' do
    context 'when logged in successfully' do
      it 'login user by email and password  for JSON format' do
        post :create, params: { email: user.email, password: user.password }, format: :json

        expect(response.body).to eq('User is successfully logged')
      end

      it 'login user by email and password for HTML format' do
        post :create, params: { email: user.email, password: user.password }, format: :html

        expect(response).to be_truthy
      end
      
      it 'login user by phone and password for JSON format' do
        post :create, params: { phone: user.phone, password: user.password }, format: :json

        expect(response.body).to eq('User is successfully logged')
      end

      it 'login user by phone and password for HTML format' do
        post :create, params: { phone: user.phone, password: user.password }, format: :html

        expect(response).to be_truthy
      end
      
      context 'when logged in failed' do
        it 'did not login user for JSON format' do
          post :create, params: { email: 'concon@gmail.com', password: 'wrongpassword' }, format: :json

          expect(response.body).to eq('Wrong email/phone or password')
        end
        
        it 'did not login user for HTML format' do
          post :create, params: { email: 'concon@gmail.com', password: 'wrongpassword' }, format: :html

          expect(response).to be_truthy
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when user is logged out' do
      before do
        session[:user_id] = user.id
      end

      it 'successfully logged out user for JSON format' do
        delete :destroy, format: :json

        expect(response.body).to eq('User is successfully logged out')
      end
      
      it 'successfully logged out user for HTML format' do
        delete :destroy, format: :html

        expect(response).to be_truthy
      end
    end

    context 'when user was not logged in' do
      it 'can not logged out user for JSON format' do
        delete :destroy, format: :json

        expect(response.body).to eq('User was not logged before')
      end
      
      it 'can not logged out user for HTML format' do
        delete :destroy, format: :html

        expect(response).to be_truthy
      end
    end
  end
end
