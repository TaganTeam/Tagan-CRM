require 'rails_helper'

RSpec.describe 'Show Users', type: :request do

  it 'Get status if users nil' do
    get 'http://localhost:3000/api/v1/users/%7Bid%7D.json'
    expect(response.status).to eq(403)
  end

  it 'show user' do
    user = create(:user)
    get "http://localhost:3000/api/v1/users/#{user.id}.json"
    expect(response.status).to eq(200)
    expect(json['data']['id']).to eq(user.id)
  end

end