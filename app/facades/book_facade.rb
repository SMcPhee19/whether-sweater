class BookFacade
  def search_books(location, quantity)
    geocode = geocode_service.get_coordinates(location)
    lat = geocode[:results][0][:locations][0][:latLng][:lat]
    lon = geocode[:results][0][:locations][0][:latLng][:lng]

    current = weather_service.get_current_weather(lat, lon)
    forecast = {
      summary: current[:current][:condition][:text],
      temperature: current[:current][:temp_f]
    }

    books = book_service.get_books(location)
    num = quantity.to_i
    searched_books = books[:docs].take(num).map do |book|
      {
        isbn: book[:isbn],
        title: book[:title],
        publisher: book[:publisher]
      }
    end

    total_books_found = books[:numFound]

    destination = location

    Books.new(forecast, searched_books, total_books_found, destination)
  end

  def geocode_service
    @geocode_service ||= MapquestService.new
  end

  def weather_service
    @weather_service ||= WeatherService.new
  end

  def book_service
    @book_service ||= BookService.new
  end
end
