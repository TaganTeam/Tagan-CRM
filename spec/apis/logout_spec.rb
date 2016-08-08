require 'rails_helper'

RSpec.describe 'Logout', type: :request do
  it 'return status success' do
    user = create(:user)
    post 'http://localhost:3000/api/v1/login.json', login: user.email, password: user.password
    access_token = json['data']['access_token']

    delete "http://localhost:3000/api/v1/logout.json?access_token=#{access_token}"
    expect(json['message']).to eq('You are logged out successfully')
  end
end