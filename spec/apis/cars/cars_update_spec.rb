require 'rails_helper'

RSpec.describe 'Update Cars"', type: :request do
  it 'when cars nil' do
    get 'http://localhost:3000/api/v1/cars/%7Bid%7D.json'
    expect(response.status).to eq(500)
  end

  it 'update' do
    car = create(:car)
    get "http://localhost:3000/api/v1/cars/#{car.id}.json"
    expect(response.status).to eq(200)
    expect(json['status']).to eq('success')
  end
end