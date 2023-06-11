class Forecast
  attr_reader :id,
              :type,
              :current_weather,
              :hourly_weather,
              :daily_weather

  def initialize(current_weather, hourly_weather, daily_weather)
    @id = nil
    @type = 'forecast'
    @current_weather = current_weather
    @hourly_weather = hourly_weather
    @daily_weather = daily_weather
  end
end