require 'rails_helper'

RSpec.describe User, type: :model do
  it 'encrypted password' do
    @user = User.new(email: 'email@a.com', name: 'Max')
    @user.password = 'password'
    expect(@user.encrypted_password).to_not eq('password')
    expect(@user.password).to eq('password')
    expect(@user.password).to_not eq('password123')
  end
end
