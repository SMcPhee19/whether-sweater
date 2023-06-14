# spec/requests/api/v0/session_request_spec.rb
require 'rails_helper'

RSpec.describe 'session request' do
  describe 'happy path' do
    it 'can create a session', :vcr do
      user = User.create!(email: 'thisisanemail@email.com', password: 'password', password_confirmation: 'password')

      user_params = {
        "email": 'thisisanemail@email.com',
        "password": 'password',
        "password_confirmation": 'password'
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v0/sessions', headers:, params: JSON.generate(user_params)
      user = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(user).to be_a(Hash)

      expect(user).to have_key(:data)
      expect(user[:data]).to be_a(Hash)

      expect(user[:data]).to have_key(:id)
      expect(user[:data][:id]).to be_a(String)

      expect(user[:data]).to have_key(:type)
      expect(user[:data][:type]).to be_a(String)

      expect(user[:data]).to have_key(:attributes)
      expect(user[:data][:attributes]).to be_a(Hash)
      # inside attributes hash
      expect(user[:data][:attributes]).to have_key(:email)
      expect(user[:data][:attributes][:email]).to be_a(String)
      expect(user[:data][:attributes][:email]).to eq(user_params[:email])
      expect(user[:data][:attributes]).to have_key(:api_key)
      expect(user[:data][:attributes][:api_key]).to be_a(String)
      # attributes does not include password or password_confirmation
      expect(user[:data][:attributes]).to_not have_key(:password)
      expect(user[:data][:attributes]).to_not have_key(:password_confirmation)
    end
  end

  describe 'sad path' do
    it 'create session - sad path - wrong email', :vcr do
      user = User.create!(email: 'thisisanemail@email.com', password: 'password', password_confirmation: 'password')

      user_params = {
        "email": 'thisisnottherightemail@email.com',
        "password": 'password'
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v0/sessions', headers:, params: JSON.generate(user_params)
      error = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(error).to be_a(Hash)
      expect(error).to have_key(:error)
      expect(error[:error]).to eq('Invalid email or password')
    end

    it 'create session - sad path - wrong password', :vcr do
      user = User.create!(email: 'nuggetsarethenbachampions@email.com', password: 'smugggets',
                          password_confirmation: 'smugggets')

      user_params = {
        "email": 'nuggetsarethenbachampions@email.com',
        "password": 'nugglife'
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v0/sessions', headers:, params: JSON.generate(user_params)
      error = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(error).to be_a(Hash)
      expect(error).to have_key(:error)
      expect(error[:error]).to eq('Invalid email or password')
    end
  end
end
