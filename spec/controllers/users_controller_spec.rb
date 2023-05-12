# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST #create' do
    context 'when creating user' do
      let(:params) do
        {
          phone: '+79384738987',
          nickname: 'Artick',
          password: 'test',
          email: 'hello.hi@test.com'
        }
      end

      it 'creates user for JSON format' do
        post :create, params: params, format: :json

        expect(JSON.parse(response.body)).to include(params.stringify_keys)
      end

      it 'creates user for HTML format' do
        post :create, params: params, format: :html

        expect(response).to be_truthy
      end
    end
  end
end
