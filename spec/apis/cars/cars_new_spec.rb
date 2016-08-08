require 'rails_helper'

RSpec.describe 'Add car', type: :request do
  it 'return succesfully message' do
    post 'http://localhost:3000/api/v1/cars.json', name: 'audi', is_stock: true, max_speed: 250, price: 3000000
    expect(json['message']).to eq('Car is added succesfully')
  end
end