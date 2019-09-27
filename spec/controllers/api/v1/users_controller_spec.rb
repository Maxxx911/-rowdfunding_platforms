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
      expect(json_response.keys).to eq(%w[errors])
    end
  end

  describe 'GET edit' do
    it 'return status 200 and user as json' do
      @user = User.new(email: 'email@a.com', name: 'Max')
      @user.password = 'password'
      @user.save
      get :edit, params: {id: @user.id}
      expect(response).to have_http_status(200)
      expect(json_response.keys).to eq(%w[id name email
                                          encrypted_password created_at updated_at])
    end

    it 'return status 400 and error message' do
      get :edit, params: {id: 1111}
      expect(response).to have_http_status(400)
      expect(json_response.keys).to eq(%w[errors])
    end
  end

  describe 'POST sign_in' do
    it 'valid params' do
      @user = User.new(email: 'email@a.com', name: 'Max')
      @user.password = 'password'
      @user.save
      post :sign_in, params: {user: {email: 'email@a.com', password: 'password'}}
      expect(response).to have_http_status(200)
      expect(json_response.keys).to eq(%w[id name email
                                          encrypted_password created_at updated_at])
    end

    it 'invalid email' do
      @user = User.new(email: 'email@a.com', name: 'Max')
      @user.password = 'password'
      @user.save
      post :sign_in, params: {user: {email: 'email12312312@a.com', password: 'password'}}
      expect(response).to have_http_status(400)
      expect(json_response.keys).to eq(%w[errors])
    end

    it 'invalid password' do
      @user = User.new(email: 'email@a.com', name: 'Max')
      @user.password = 'password'
      @user.save
      post :sign_in, params: {user: {email: 'email@a.com', password: 'password123'}}
      expect(response).to have_http_status(400)
      expect(json_response.keys).to eq(%w[errors])
    end
  end

  describe 'PATCH update' do
    it 'valid params' do
      @user = User.new(email: 'email@a.com', name: 'Max')
      @user.password = 'password'
      @user.save
      patch :update, params: {id: @user.id, user: {name: 'new name'}}
      expect(response).to have_http_status(200)
      expect(json_response.first['name']).to eq('new name')
    end

    it 'invalid params' do
      patch :update, params: {id: 11111, user: {name: 'new name'}}
      expect(response).to have_http_status(400)
      expect(json_response.keys).to eq(%w[errors])
    end

    it 'update password and email' do
      @user = User.new(email: 'email@a.com', name: 'Max')
      @user.password = 'password'
      @user.save
      patch :update, params: {id: @user.id, user: {email: 'new email', password: 'new password'}}
      expect(response).to have_http_status(200)
      expect(json_response.first['email']).to eq(@user.email)
      expect(json_response.first['name']).to eq(@user.name)
      expect(json_response.first['encrypted_password']).to eq(@user.password)
    end
  end
end
