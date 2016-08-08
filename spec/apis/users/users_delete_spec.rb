require 'rails_helper'

RSpec.describe 'Delete Users', type: :request do

  it 'are nil' do
    get 'http://localhost:3000/api/v1/users/%7Bid%7D.json'
    expect(response.status).to eq(403)
  end

  it 'delete' do
    user = create(:user)
    delete "http://localhost:3000/api/v1/users/#{user.id}.json"
    expect(response.status).to eq(200)
    expect(json['data']['id']).to eq(user.id)
  end

end