require 'rails_helper'

RSpec.describe 'Login', :type => :request do
  it 'return status success' do
    user = create(:user)
    post 'http://localhost:3000/api/v1/login.json', login: user.email, password: user.password
    expect(json['status']).to eq('success')
  end
end