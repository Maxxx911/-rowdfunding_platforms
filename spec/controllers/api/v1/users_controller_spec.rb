require 'rails_helper'

RSpec.describe Api::V1::UsersController do
  describe 'POST create' do
    it 'valid params' do
      post :create, params: { login: 'Best',
                              email: 'example@email.com',
                              password: 'qwerty',
                              confirm_password: 'qwerty',
                              first_name: 'Maxim',
                              middle_name: 'Middle name',
                              last_name: 'Last name',
                              birthday: Date.today,
                              role: 'admin' }
      expect(response).to have_http_status(200)
      expect(json_response.keys).to eq(%w[success errors result])
    end

    it 'invalid params' do
      post :create, params: { firs_name: 'Maxim' }
      expect(json_response.keys).to eq(%w[success errors result])
    end
  end

  describe 'POST sign_in' do
    before do
      @user = User.new( 
        login: 'Best',
        email: 'example@email.com',
        first_name: 'Maxim',
        middle_name: 'Middle name',
        last_name: 'Last name',
        birthday: Date.today
      )
      @user.password = 'password'
      @user.token = GenerateTokenService.generate(@user)
      @user.save
    end

    it 'valid params' do
      post :sign_in, params: { login: @user.login , password: 'password' }
      expect(response).to have_http_status(200)
      expect(json_response.keys).to eq(%w[success errors result])
      expect(json_response['errors'].count).to eq(0)
      expect(json_response['result']['token']).to eq(@user.token)
    end

    it 'invalid login' do
      post :sign_in, params: { login: @user.login + '1', password: 'password' }
      expect(response).to have_http_status(200)
      expect(json_response.keys).to eq(%w[success errors result])
      expect(json_response['errors'].count).not_to eq(0)
    end

    it 'invalid password' do
      post :sign_in, params: { login: @user.login, password: 'wrong_password' }
      expect(response).to have_http_status(200)
      expect(json_response.keys).to eq(%w[success errors result])
      expect(json_response['errors'].count).not_to eq(0)
    end
  end

  describe 'PATCH change password' do
    before do
      @user = User.new( 
        login: 'Best',
        email: 'example@email.com',
        first_name: 'Maxim',
        middle_name: 'Middle name',
        last_name: 'Last name',
        birthday: Date.today
      )
      @user.password = 'password'
      @user.token = GenerateTokenService.generate(@user)
      @user.save
    end

    it 'valid params' do
      patch :change_password,
            params: { id: @user.id,
                      token: @user.token,
                      password: 'password',
                      new_password: 'new password',
                      confirm_new_password: 'new password' }
      expect(response).to have_http_status(200)
      expect(json_response.keys).to eq(%w[success errors result])
      expect(json_response['errors'].count).to eq(0)
    end

    it 'invalid password' do
      patch :change_password,
            params: { id: @user.id,
                      token: @user.token,
                      password: 'password123',
                      new_password: 'new password',
                      confirm_new_password: 'new password' }
      expect(response).to have_http_status(200)
      expect(json_response.keys).to eq(%w[success errors result])
      expect(json_response['errors'].count).not_to eq(0)
    end

    it 'invalid confirm_new_password' do
      patch :change_password,
            params: { id: @user.id,
                      token: @user.token,
                      password: 'password',
                      new_password: 'new password',
                      confirm_new_password: 'new password123' }
      expect(response).to have_http_status(200)
      expect(json_response.keys).to eq(%w[success errors result])
      expect(json_response['errors'].count).not_to eq(0)
    end
  end

  describe 'PATCH update user' do
    before do
      @user = User.new( 
        login: 'Best',
        email: 'example@email.com',
        first_name: 'Maxim',
        middle_name: 'Middle name',
        last_name: 'Last name',
        birthday: Date.today
      )
      @user.password = 'password'
      @user.token = GenerateTokenService.generate(@user)
      @user.save
    end

    it 'Update first name' do
      patch :update, params: { id: @user.id,
                              token: @user.token,
                              first_name: 'new first name'
                             }
      expect(response).to have_http_status(200)
      expect(json_response.keys).to eq(%w[success errors result])
      expect(json_response['errors'].count).to eq(0)
    end

    it 'Update middle name' do
      patch :update, params: { id: @user.id,
                               token: @user.token,
                               middle_name: 'new first name'
       }
      expect(response).to have_http_status(200)
      expect(json_response.keys).to eq(%w[success errors result])
      expect(json_response['errors'].count).to eq(0)
    end

    it 'Update last name' do
      patch :update, params: { id: @user.id,
                               token: @user.token,
                               last_name: 'new first name'
       }
      expect(response).to have_http_status(200)
      expect(json_response.keys).to eq(%w[success errors result])
      expect(json_response['errors'].count).to eq(0)
    end

    it 'Update birthday' do
      patch :update, params: { id: @user.id,
                               token: @user.token,
                               birthday: Date.today
       }
      expect(response).to have_http_status(200)
      expect(json_response.keys).to eq(%w[success errors result])
      expect(json_response['errors'].count).to eq(0)
    end

    it 'Update email' do
      patch :update, params: { id: @user.id,
                               token: @user.token,
                               email: 'new@email.com'
       }
      expect(response).to have_http_status(200)
      expect(json_response.keys).to eq(%w[success errors result])
      expect(json_response['errors'].count).to eq(0)
    end
  end
end
