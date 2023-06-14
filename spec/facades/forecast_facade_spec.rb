require 'rails_helper'

RSpec.describe 'forecast facade' do
  it 'can get forecast data', :vcr do
    location = 'Denver,CO'
    weather = ForecastFacade.new.get_forecast(location)

    expect(weather).to be_a(Forecast)
    expect(weather.id).to eq(nil)
    expect(weather.type).to eq('forecast')
    expect(weather.current_weather).to be_a(Hash)
    expect(weather.daily_weather).to be_a(Array)
    expect(weather.hourly_weather).to be_a(Array)
  end
end
