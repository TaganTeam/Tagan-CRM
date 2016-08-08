require 'rails_helper'

RSpec.describe 'Show Cars', type: :request do
  it 'if cars nil' do
    get 'http://localhost:3000/api/v1/users/%7Bid%7D.json'
    expect(response.status).to eq(403)
  end

  it 'show' do
    car = create(:car)
    get "http://localhost:3000/api/v1/cars/#{car.id}.json"
    expect(response.status).to eq(200)
    expect(json['data']['id']).to eq(car.id)
  end
end