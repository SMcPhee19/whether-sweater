class Search
  attr_reader :id,
              :type,
              :current_weather,
              :searched_books,
              :total_books

  def initialize(current_weather, searched_books, total_books)
    @id = nil
    @type = 'books'
    @current_weather = current_weather
    @searched_books = searched_books
    @total_books = total_books
  end
end