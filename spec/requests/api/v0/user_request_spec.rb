# spec/requests/api/v0/user_request_spec.rb
require 'rails_helper'

RSpec.describe 'user request' do
  it 'user creation - happy path', :vcr do
    user_params = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }

    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v0/users', headers: headers, params: JSON.generate(user_params)

    expect(response).to be_successful
    expect(response.status).to eq(201)
  end
end