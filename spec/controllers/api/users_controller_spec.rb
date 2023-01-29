# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
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

      it 'creates user' do
        post :create, params: params

        expect(JSON.parse(response.body)).to include(params.stringify_keys)
      end
    end
  end
end
