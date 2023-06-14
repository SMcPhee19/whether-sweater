require 'rails_helper'

RSpec.describe 'forecast' do
  before(:each) do
    @location = 'Denver,CO'
    @weather = ForecastFacade.new.get_forecast(@location)
  end

  it 'exists with attributes', :vcr do
    expect(@weather).to be_a(Forecast)
    expect(@weather.id).to eq(nil)
    expect(@weather.type).to eq('forecast')
    expect(@weather.current_weather).to be_a(Hash)
    expect(@weather.daily_weather).to be_a(Array)
    expect(@weather.hourly_weather).to be_a(Array)
  end

  it 'current weather has attributes', :vcr do
    current_weather = @weather.current_weather

    expect(current_weather).to be_a(Hash)
    expect(current_weather).to have_key(:last_updated)
    expect(current_weather[:last_updated]).to be_a(String)
    expect(current_weather).to have_key(:temperature)
    expect(current_weather[:temperature]).to be_a(Float)
    expect(current_weather).to have_key(:feels_like)
    expect(current_weather[:feels_like]).to be_a(Float)
    expect(current_weather).to have_key(:humidity)
    expect(current_weather[:humidity]).to be_a(Integer)
    expect(current_weather).to have_key(:uv)
    expect(current_weather[:uv]).to be_a(Float)
    expect(current_weather).to have_key(:visibility)
    expect(current_weather[:visibility]).to be_a(Float)
    expect(current_weather).to have_key(:conditions)
    expect(current_weather[:conditions]).to be_a(String)
    expect(current_weather).to have_key(:icon)
    expect(current_weather[:icon]).to be_a(String)
  end

  it 'daily weather has attributes', :vcr do
    daily_weather = @weather.daily_weather

    expect(daily_weather).to be_a(Array)
    expect(daily_weather.count).to eq(5)

    daily_weather.each do |day|
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
    end
  end

  it 'hourly weather has attributes', :vcr do
    hourly_weather = @weather.hourly_weather

    expect(hourly_weather).to be_a(Array)
    expect(hourly_weather.count).to eq(24)

    hourly_weather.each do |hour|
      expect(hour).to be_a(Hash)
      expect(hour).to have_key(:time)
      expect(hour[:time]).to be_a(String)
      expect(hour).to have_key(:temperature)
      expect(hour[:temperature]).to be_a(Float)
      expect(hour).to have_key(:conditions)
      expect(hour[:conditions]).to be_a(String)
      expect(hour).to have_key(:icon)
      expect(hour[:icon]).to be_a(String)
    end
  end
end
