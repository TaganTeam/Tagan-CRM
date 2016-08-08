require 'rails_helper'

RSpec.describe 'Update Users', type: :request do
  it 'when users nil' do
    get 'http://localhost:3000/api/v1/users/%7Bid%7D.json'
    expect(response.status).to eq(403)
  end

  it 'update' do
    user = create(:user)
    get "http://localhost:3000/api/v1/users/#{user.id}.json"
    expect(response.status).to eq(200)
    expect(json['status']).to eq('success')
  end

end