require 'rails_helper'

RSpec.describe 'Users', type: :request do

  it 'has a valid Factory' do
    build(:user).should be_valid
  end

  it 'Get status response' do
    get 'http://localhost:3000/api/v1/users/users.json'
    expect(response.status).to eq(200)
  end

  it 'Get all users' do
    user1 = create(:user)
    user2 = create(:user)
    user3 = create(:user)
    user4 = create(:user)
    user5 = create(:user)
    user6 = create(:user)
    user7 = create(:user)
    user8 = create(:user)

    get 'http://localhost:3000/api/v1/users/users.json'
    i = 8
    json['data'].each do |hh|
      hh.each_value do |value|
        user = User.find(i)
        expect(value).to eq(user.id)
        break
      end
      i += 1
    end
    # expect(response).to_not render_template(:login)
  end
end