require 'rails_helper'

RSpec.describe 'Cars', type: :request do
  it 'has a valid Factory' do
    build(:car).should be_valid
  end

  it 'Get status response' do
    car1 = create(:car)
    car2 = create(:car)
    car3 = create(:car)
    car4 = create(:car)
    car5 = create(:car)
    car6 = create(:car)

    get 'http://localhost:3000/api/v1/cars/cars.json'
    expect(response.status).to eq(200)
    i = 4
    json['data'].each do |hh|
      hh.each_value do |value|
        car = Car.find(i)
        expect(value).to eq(car.id)
        break
      end
      i += 1
    end
  end
end