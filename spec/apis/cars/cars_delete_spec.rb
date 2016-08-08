require 'rails_helper'

RSpec.describe 'Delete Cars', type: :request do
  it 'are nil' do
    get 'http://localhost:3000/api/v1/cars/%7Bid%7D.json'
    expect(response.status).to eq(500)
  end

  it 'delete' do
    car = create(:car)
    delete "http://localhost:3000/api/v1/cars/#{car.id}.json"
    expect(response.status).to eq(200)
    expect(json['data']['id']).to eq(car.id)
  end
end