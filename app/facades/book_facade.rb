class BookFacade
  def search_books(location, quantity)
    geocode = geocode_service.get_coordinates(location)
    lat = geocode[:results][0][:locations][0][:latLng][:lat]
    lon = geocode[:results][0][:locations][0][:latLng][:lng]

    current = weather_service.get_current_weather(lat, lon)
    current_weather = {
      conditions: current[:current][:condition][:text],
      temperature: current[:current][:temp_f]
    }

    books = book_service.get_books(location)
    searched_books = books[:docs].map[0..quantity] do |book|
    require 'pry'; binding.pry
    {
      isbn: book[:isbn],
      title: book[:title]
    }
  end

  def geocode_service
    @geocode_service ||= GeocodeService.new
  end

  def weather_service
    @weather_service ||= WeatherService.new
  end

  def book_service
    @book_service ||= BookService.new
  end
end