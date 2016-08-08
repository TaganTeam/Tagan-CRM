require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  it 'return succesfully message' do
    post 'http://localhost:3000/api/v1/register.json', email: 'qq@ww.com', password: '123456'
    expect(json['message']).to eq('Your account is registered successfully')
  end
end


