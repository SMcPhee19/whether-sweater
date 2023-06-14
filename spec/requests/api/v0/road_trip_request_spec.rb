require 'rails_helper'

RSpec.describe 'road trip request' do
  describe 'happy path' do
    it 'happy path - can get road trip data', :vcr do
      user = User.create!(email: 'random@email.com', password: 'password', password_confirmation: 'password')
      start = 'los angeles,ca'
      destination = 'new york,ny'

      params = {
        "origin": start,
        "destination": destination,
        "api_key": user.api_key
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v0/road_trip', headers: headers, params: JSON.generate(params)
      trip = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      expect(trip).to be_a(Hash)

      expect(trip).to have_key(:data)
      expect(trip[:data]).to have_key(:id)
      expect(trip[:data][:id]).to eq('null')
      expect(trip[:data]).to have_key(:type)
      expect(trip[:data][:type]).to eq('road_trip')
      expect(trip[:data]).to have_key(:attributes)
      expect(trip[:data][:attributes]).to be_a(Hash) 
      expect(trip[:data][:attributes]).to have_key(:start_city)
      expect(trip[:data][:attributes][:start_city]).to be_a(String)
      expect(trip[:data][:attributes][:start_city]).to eq('los angeles,ca')
      expect(trip[:data][:attributes]).to have_key(:end_city)
      expect(trip[:data][:attributes][:end_city]).to be_a(String)
      expect(trip[:data][:attributes][:end_city]).to eq('new york,ny')
      expect(trip[:data][:attributes]).to have_key(:travel_time)
      expect(trip[:data][:attributes][:travel_time]).to be_a(String)
      expect(trip[:data][:attributes]).to have_key(:weather_at_eta)
      expect(trip[:data][:attributes][:weather_at_eta]).to be_a(Hash)
      expect(trip[:data][:attributes][:weather_at_eta]).to have_key(:datetime)
      expect(trip[:data][:attributes][:weather_at_eta][:datetime]).to be_a(String)
      expect(trip[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
      expect(trip[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
      expect(trip[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
      expect(trip[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
    end
  end

  describe 'sad path' do
    it 'sad path - impossible route', :vcr do
      user = User.create!(email: 'random@email.com', password: 'password', password_confirmation: 'password')
      start = 'los angeles,ca'
      destination = 'london,uk'

      params = {
        "origin": start,
        "destination": destination,
        "api_key": user.api_key
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v0/road_trip', headers: headers, params: JSON.generate(params)
      impossible = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      expect(impossible).to be_a(Hash)
      expect(impossible).to have_key(:data)
      expect(impossible[:data]).to have_key(:id)
      expect(impossible[:data][:id]).to eq('null')
      expect(impossible[:data]).to have_key(:type)
      expect(impossible[:data][:type]).to eq('road_trip')
      expect(impossible[:data]).to have_key(:attributes)
      expect(impossible[:data][:attributes]).to be_a(Hash) 
      expect(impossible[:data][:attributes]).to have_key(:start_city)
      expect(impossible[:data][:attributes][:start_city]).to be_a(String)
      expect(impossible[:data][:attributes][:start_city]).to eq('los angeles,ca')
      expect(impossible[:data][:attributes]).to have_key(:end_city)
      expect(impossible[:data][:attributes][:end_city]).to be_a(String)
      expect(impossible[:data][:attributes][:end_city]).to eq('london,uk')
      expect(impossible[:data][:attributes]).to have_key(:travel_time)
      expect(impossible[:data][:attributes][:travel_time]).to be_a(String)
      expect(impossible[:data][:attributes][:travel_time]).to eq('impossible route')
      expect(impossible[:data][:attributes][:weather_at_eta]).to eq({})
    end

    it 'sad path - invalid api key', :vcr do
      user = User.create!(email: 'random@email.com', password: 'password', password_confirmation: 'password')
      start = 'los angeles,ca'
      destination = 'london,uk'

      params = {
        "origin": start,
        "destination": destination,
        "api_key": 'thisisnotavalidkey'
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v0/road_trip', headers: headers, params: JSON.generate(params)
      error = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      expect(error).to be_a(Hash)
      expect(error).to have_key(:error)
      expect(error[:error]).to eq('Invalid API key')
    end
  end
end