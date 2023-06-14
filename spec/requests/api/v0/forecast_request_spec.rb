# spec/requests/api/v0/forecast_request_spec.rb
require 'rails_helper'

RSpec.describe 'forecast request' do
  describe 'happy path' do
    it 'can get forecast data', :vcr do
      location = 'Littleton,CO'

      get "/api/v0/forecast?location=#{location}"

      expect(response).to be_successful

      forecast = JSON.parse(response.body, symbolize_names: true)

      expect(forecast).to be_a(Hash)

      expect(forecast).to have_key(:data)
      expect(forecast[:data]).to be_a(Hash)
      expect(forecast[:data]).to have_key(:id)
      expect(forecast[:data][:id]).to eq(nil)
      expect(forecast[:data]).to have_key(:type)
      expect(forecast[:data][:type]).to eq('forecast')
      expect(forecast[:data]).to have_key(:attributes)
      expect(forecast[:data][:attributes]).to be_a(Hash)

      # current weather
      expect(forecast[:data][:attributes]).to have_key(:current_weather)
      expect(forecast[:data][:attributes][:current_weather]).to be_a(Hash)
      expect(forecast[:data][:attributes][:current_weather]).to have_key(:last_updated)
      expect(forecast[:data][:attributes][:current_weather][:last_updated]).to be_a(String)
      expect(forecast[:data][:attributes][:current_weather]).to have_key(:temperature)
      expect(forecast[:data][:attributes][:current_weather][:temperature]).to be_a(Float)
      expect(forecast[:data][:attributes][:current_weather]).to have_key(:feels_like)
      expect(forecast[:data][:attributes][:current_weather][:feels_like]).to be_a(Float)
      expect(forecast[:data][:attributes][:current_weather]).to have_key(:humidity)
      expect(forecast[:data][:attributes][:current_weather][:humidity]).to be_a(Integer)
      expect(forecast[:data][:attributes][:current_weather]).to have_key(:uv)
      expect(forecast[:data][:attributes][:current_weather][:uv]).to be_a(Float)
      expect(forecast[:data][:attributes][:current_weather]).to have_key(:visibility)
      expect(forecast[:data][:attributes][:current_weather][:visibility]).to be_a(Float)
      expect(forecast[:data][:attributes][:current_weather]).to have_key(:conditions)
      expect(forecast[:data][:attributes][:current_weather][:conditions]).to be_a(String)
      expect(forecast[:data][:attributes][:current_weather]).to have_key(:icon)
      expect(forecast[:data][:attributes][:current_weather][:icon]).to be_a(String)

      # not included in current weather
      expect(forecast[:data][:attributes][:current_weather]).to_not have_key(:is_day)
      expect(forecast[:data][:attributes][:current_weather]).to_not have_key(:wind_kph)
      expect(forecast[:data][:attributes][:current_weather]).to_not have_key(:precip_in)
      expect(forecast[:data][:attributes][:current_weather]).to_not have_key(:cloud)

      # daily weather
      expect(forecast[:data][:attributes][:daily_weather].count).to eq(5)
      expect(forecast[:data][:attributes][:daily_weather]).to be_an(Array)
      # each day
      forecast[:data][:attributes][:daily_weather].each do |day|
        expect(day).to be_a(Hash)
        expect(day).to have_key(:date)
        expect(day[:date]).to be_a(String)
        expect(day).to have_key(:sunrise)
        expect(day[:sunrise]).to be_a(String)
        expect(day).to have_key(:sunset)
        expect(day[:sunset]).to be_a(String)
        expect(day).to have_key(:max_temp)
        expect(day[:max_temp]).to be_a(Float)
        expect(day).to have_key(:min_temp)
        expect(day[:min_temp]).to be_a(Float)
        expect(day).to have_key(:conditions)
        expect(day[:conditions]).to be_a(String)
        expect(day).to have_key(:icon)
        expect(day[:icon]).to be_a(String)
        # not included in daily weather
        expect(day).to_not have_key(:daily_will_it_rain)
        expect(day).to_not have_key(:daily_will_it_snow)
        expect(day).to_not have_key(:daily_chance_of_rain)
        expect(day).to_not have_key(:daily_chance_of_snow)
        expect(day).to_not have_key(:avgtemp_f)
      end

      # hourly weather
      expect(forecast[:data][:attributes][:hourly_weather].count).to eq(24)
      expect(forecast[:data][:attributes][:hourly_weather]).to be_an(Array)
      # each hour
      forecast[:data][:attributes][:hourly_weather].each do |hour|
        expect(hour).to be_a(Hash)
        expect(hour).to have_key(:time)
        expect(hour[:time]).to be_a(String)
        expect(hour).to have_key(:temperature)
        expect(hour[:temperature]).to be_a(Float)
        expect(hour).to have_key(:conditions)
        expect(hour[:conditions]).to be_a(String)
        expect(hour).to have_key(:icon)
        expect(hour[:icon]).to be_a(String)
        # not included in hourly weather
        expect(hour).to_not have_key(:cloud)
        expect(hour).to_not have_key(:windchill_f)
        expect(hour).to_not have_key(:wind_dir)
        expect(hour).to_not have_key(:humidity)
      end
    end
  end

  describe 'sad path' do
    it 'returns an error if location is not provided', :vcr do
      location = ''
      get "/api/v0/forecast?location=#{location}"

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a(Hash)
      expect(error).to have_key(:error)
      expect(error[:error]).to eq('No location given')
    end
  end
end
