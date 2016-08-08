require 'rails_helper'

RSpec.describe 'Users profile', type: :request do

  it 'Get status response if user are not authenticate' do
    get 'http://localhost:3000/api/v1/users/profile.json'
    expect(response.status).to eq(500)
  end

  it 'Authenticate!' do
    user = create(:user)
    login_as(user, scope: :user)
    get 'http://localhost:3000/'
    expect(response).to render_template('layouts/application')
    logout(:user)
  end

  it 'Get status response if user authenticated' do
    user = create(:user)
    login_as(user, scope: :user)
    get 'http://localhost:3000/api/v1/users/profile.json'
    expect(response.status).to eq(200)
    expect(json['data']['id']).to eq(user.id)
    logout(:user)
  end
end