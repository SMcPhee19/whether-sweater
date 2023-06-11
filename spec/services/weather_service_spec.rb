require 'rails_helper'

RSpec.describe WeatherService do
  it 'returns the current weather', :vcr do
    service = WeatherService.new
    weather = service.get_current_weather(39.74001, -104.99202)

    expect(weather).to be_a(Hash)

    expect(weather[:location]).to be_a(Hash)
    expect(weather[:location]).to have_key(:name)
    expect(weather[:location][:name]).to be_a(String)
    expect(weather[:location]).to have_key(:region)
    expect(weather[:location][:region]).to be_a(String)
    expect(weather[:location]).to have_key(:lat)
    expect(weather[:location][:lat]).to be_a(Float)
    expect(weather[:location]).to have_key(:lon)
    expect(weather[:location][:lon]).to be_a(Float)

    expect(weather[:current]).to be_a(Hash)
    expect(weather[:current]).to have_key(:last_updated)
    expect(weather[:current][:last_updated]).to be_a(String)
    expect(weather[:current]).to have_key(:temp_f)
    expect(weather[:current][:temp_f]).to be_a(Float)
    expect(weather[:current]).to have_key(:condition)
    expect(weather[:current][:condition]).to be_a(Hash)
    expect(weather[:current][:condition]).to have_key(:text)
    expect(weather[:current][:condition][:text]).to be_a(String)
    expect(weather[:current][:condition]).to have_key(:icon)
    expect(weather[:current][:condition][:icon]).to be_a(String) 
    expect(weather[:current]).to have_key(:humidity)
    expect(weather[:current][:humidity]).to be_an(Integer)
    expect(weather[:current]).to have_key(:feelslike_f)
    expect(weather[:current][:feelslike_f]).to be_a(Float)
    expect(weather[:current]).to have_key(:vis_miles)
    expect(weather[:current][:vis_miles]).to be_a(Float)
    expect(weather[:current]).to have_key(:uv)
    expect(weather[:current][:uv]).to be_a(Float)
  end

  it 'returns the daily weather', :vcr do
    service = WeatherService.new
    daily_weather = service.get_daily(39.74001, -104.99202)

    expect(daily_weather).to be_a(Hash)

    daily_weather[:forecast][:forecastday].each do |day|
      expect(day).to be_an(Hash)
      
      expect(day).to have_key(:date)
      expect(day[:date]).to be_a(String)
      expect(day).to have_key(:day)
      expect(day[:day]).to be_a(Hash)
      expect(day[:day]).to have_key(:maxtemp_f)
      expect(day[:day][:maxtemp_f]).to be_a(Float)
      expect(day[:day]).to have_key(:mintemp_f)
      expect(day[:day][:mintemp_f]).to be_a(Float)
      
      expect(day[:day]).to have_key(:condition)
      expect(day[:day][:condition]).to be_a(Hash)
      expect(day[:day][:condition]).to have_key(:text)
      expect(day[:day][:condition][:text]).to be_a(String)
      expect(day[:day][:condition]).to have_key(:icon)
      expect(day[:day][:condition][:icon]).to be_a(String)

      expect(day).to have_key(:astro)
      expect(day[:astro]).to be_a(Hash)
      expect(day[:astro]).to have_key(:sunrise)
      expect(day[:astro][:sunrise]).to be_a(String)
      expect(day[:astro]).to have_key(:sunset)
      expect(day[:astro][:sunset]).to be_a(String)
    end
  end
end