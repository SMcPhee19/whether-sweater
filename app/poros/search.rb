class Search
  attr_reader :id,
              :type,
              :current_weather,
              :searched_books,
              :total_books,
              :destination

  def initialize(current_weather, searched_books, total_books, destination)
    @id = nil
    @type = 'books'
    @current_weather = current_weather
    @searched_books = searched_books
    @total_books = total_books
    @destination = destination
  end
end