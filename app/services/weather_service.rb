class WeatherService
  def get_current_weather(lat, lon)
    get_url("/v1/current.json?q=#{lat},#{lon}")
  end

  def get_daily(lat, lon)
    get_url("/v1/forecast.json?q=#{lat},#{lon}&days=5")
  end

  def get_hourly(lat, lon)
    get_url("/v1/forecast.json?q=#{lat},#{lon}")
  end

  private

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'http://api.weatherapi.com') do |f|
      f.params['key'] = ENV['WEATHER_API_KEY']
    end
  end
end
