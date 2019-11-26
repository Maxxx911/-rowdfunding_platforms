require 'rails_helper'

RSpec.describe Api::V1::ProjectsController do
  before do
    @user = User.new(
      login: 'Best',
      email: 'example@email.com',
      first_name: 'Maxim',
      middle_name: 'Middle name',
      last_name: 'Last name',
      birthday: Date.today,
      role: 'admin'
    )
    @user.password = 'password'
    @user.token = GenerateTokenService.generate(@user)
    @user.save

    @categories_id = []
    @categories_id << Category.find_or_create_by(name: 'first').id
    @categories_id << Category.find_or_create_by(name: 'second').id
    @categories_id << Category.find_or_create_by(name: 'third').id

    @project = Project.create(
      title: 'first',
      description: 'First description',
      image_url: 'https://riafan.ru/uploads/2018/05/12/orig-1526128107315bc0def6e8cdb0d4c0bf3b0a0ab23c.jpeg',
      end_time: Date.today + 15.day,
      sum_goal: 200,
      current_sum: 0,
      owner: @user
    )
  end

  describe 'POST create' do
    it 'valid params' do
      post :create, params: { user_token: @user.token,
                              title: 'first',
                              description: 'First description',
                              image_url: 'https://riafan.ru/uploads/2018/05/12/orig-1526128107315bc0def6e8cdb0d4c0bf3b0a0ab23c.jpeg',
                              end_time: Date.today + 15.day,
                              sum_goal: 200,
                              categories_id: @categories_id,
                              current_sum: 0 }
      expect(json_response.keys).to eq(%w[success errors result])
      expect(json_response['errors'].count).to eq(0)
    end
  end

  describe 'PATCH update project' do
    it 'Update title' do
      patch :update, params: { id: @project.id, user_token: @user.token, title: 'new title'}
      expect(response).to have_http_status(200)
      expect(json_response.keys).to eq(%w[success errors result])
      expect(json_response['errors'].count).to eq(0)
    end

    it 'Invalid user token' do
      patch :update, params: { id: @project.id, user_token: 'invalid token', title: 'new title'}
      expect(response).to have_http_status(200)
      expect(json_response.keys).to eq(%w[success errors result])
      expect(json_response['errors'].count).not_to eq(0)
    end
  end

  describe 'DELETE delete project' do
    it 'Delete project' do
      delete :destroy, params: { id: @project.id, user_token: @user.token }
      expect(response).to have_http_status(200)
      expect(json_response.keys).to eq(%w[success errors result])
      expect(json_response['errors'].count).to eq(0)
    end
  end

  describe 'GET show project' do
    it 'Show project' do
      get :show, params: {id: @project.id}
      expect(response).to have_http_status(200)
      expect(json_response.keys).to eq(%w[success errors result])
      expect(json_response['errors'].count).to eq(0)
      expect(json_response['result'].count).not_to eq(0)
    end
  end
end
