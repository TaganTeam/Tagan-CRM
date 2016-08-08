require 'rails_helper'

RSpec.describe 'Status', type: :request do
  it 'return status of connection to db' do
  get 'http://localhost:3000/api/v1/status.json'
  expect(json['status']).to eq('ok')
  end
end