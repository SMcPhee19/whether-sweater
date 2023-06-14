class ForecastFacade
  def get_forecast(location)
    geocode = geocode_service.get_coordinates(location)
    lat = geocode[:results][0][:locations][0][:latLng][:lat]
    lon = geocode[:results][0][:locations][0][:latLng][:lng]

    current = weather_service.get_current_weather(lat, lon)
    current_weather = {
      last_updated: current[:current][:last_updated],
      temperature: current[:current][:temp_f],
      feels_like: current[:current][:feelslike_f],
      humidity: current[:current][:humidity],
      uv: current[:current][:uv],
      visibility: current[:current][:vis_miles],
      conditions: current[:current][:condition][:text],
      icon: current[:current][:condition][:icon]
    }

    hourly = weather_service.get_hourly(lat, lon)
    hourly_weather = hourly[:forecast][:forecastday][0][:hour].map do |hour|
      {
        time: hour[:time].split[1],
        temperature: hour[:temp_f],
        conditions: hour[:condition][:text],
        icon: hour[:condition][:icon]
      }
    end

    daily = weather_service.get_daily(lat, lon)
    daily_weather = daily[:forecast][:forecastday].map do |day|
      {
        date: day[:date],
        sunrise: day[:astro][:sunrise],
        sunset: day[:astro][:sunset],
        max_temp: day[:day][:maxtemp_f],
        min_temp: day[:day][:mintemp_f],
        conditions: day[:day][:condition][:text],
        icon: day[:day][:condition][:icon]
      }
    end
    Forecast.new(current_weather, hourly_weather, daily_weather)
  end

  def geocode_service
    @geocode_service ||= MapquestService.new
  end

  def weather_service
    @weather_service ||= WeatherService.new
  end
end
