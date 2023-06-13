spec/requests/api/v0/user_request_spec.rb
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

    user = JSON.parse(response.body, symbolize_names: true)

    expect(user).to be_a(Hash)

    expect(user).to have_key(:data)
    expect(user[:data]).to be_a(Hash)

    expect(user[:data]).to have_key(:id)
    expect(user[:data][:id]).to be_a(String)

    expect(user[:data]).to have_key(:type)
    expect(user[:data][:type]).to be_a(String)

    expect(user[:data]).to have_key(:attributes)
    expect(user[:data][:attributes]).to be_a(Hash)

    expect(user[:data][:attributes]).to have_key(:email)
    expect(user[:data][:attributes][:email]).to be_a(String)

    expect(user[:data][:attributes]).to have_key(:api_key)
    expect(user[:data][:attributes][:api_key]).to be_a(String)
  end

  it 'user creation - sad path - email already taken', :vcr do
    User.create!(email: 'random@email.com', password: 'password', password_confirmation: 'password')

    user_params ={
      email: 'random@email.com',
      password: 'password',
      password_confirmation: 'password'
    }

    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v0/users', headers: headers, params: JSON.generate(user_params)

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error).to be_a(Hash)
    expect(error[:error]).to eq("Email has already been taken")
  end

  it 'user creation - sad path - password missmatch', :vcr do
    user_params ={
      email: 'random@email.com',
      password: 'password',
      password_confirmation: 'p4ssw0rd'
    }

    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v0/users', headers: headers, params: JSON.generate(user_params)

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error).to be_a(Hash)
    expect(error[:error]).to eq("Password confirmation doesn't match Password")
  end

  it 'user creation - sad path - email already taken & password mismtach', :vcr do
    User.create!(email: 'random@email.com', password: 'password', password_confirmation: 'password')

    user_params ={
      email: 'random@email.com',
      password: 'password',
      password_confirmation: 'p4ssw0rd'
    }

    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v0/users', headers: headers, params: JSON.generate(user_params)

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error).to be_a(Hash)
    expect(error[:error]).to eq("Email has already been taken and Password confirmation doesn't match Password")
  end

  it 'user creation - sad path - missing email', :vcr do
    user_params ={
      password: 'password',
      password_confirmation: 'password'
    }

    headers = { 'CONTENT_TYPE' => 'application/json' }
    post '/api/v0/users', headers: headers, params: JSON.generate(user_params)

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error).to be_a(Hash)
    expect(error[:error]).to eq("Email can't be blank")
  end
end