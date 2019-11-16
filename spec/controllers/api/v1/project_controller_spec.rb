require 'rails_helper'

RSpec.describe Api::V1::ProjectsController do
  describe 'POST create' do
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
      post :create, params: { token: @user.token
                              owner_id: @user.id,
                              title: 'first',
                              description: 'First description',
                              image_url: 'https://riafan.ru/uploads/2018/05/12/orig-1526128107315bc0def6e8cdb0d4c0bf3b0a0ab23c.jpeg'
                              end_time: Date.today + 15.day,
                              sum_doal: 200 }}
      expect(response).to have_http_status(201)
      expect(json_response.first.project.length).to_not eq(0)

    end
  end
end
