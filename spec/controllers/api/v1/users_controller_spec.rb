require 'rails_helper'

RSpec.describe Api::V1::UsersController do
  describe 'POST create' do
    it 'valid params' do
      post :create, params: {user: {email: 'example@email.com', password: 'qwerty', name: 'Maxim'}}
      expect(response).to have_http_status(201)
      expect(json_response.keys).to eq(%w[id name email
                                               encrypted_password created_at updated_at])
    end

    it 'invalid params' do
      post :create, params: {user: { name: 'Maxim'}}
      @errors = %q[all fields should not be empty]
      expect(response).to have_http_status(422)
      expect(json_response.length).to_not eq(0)
    end
  end
end
