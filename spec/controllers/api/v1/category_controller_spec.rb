require 'rails_helper'

RSpec.describe Api::V1::CategoriesController do
  describe 'Get index' do
    get :index, params: {}
    expect(json_response.keys).to eq(%w[success errors result])
    expect(json_response['errors'].count).to eq(0)
  end
end
