class Books
  attr_reader :id,
              :type,
              :forecast,
              :searched_books,
              :total_books_found,
              :destination

  def initialize(forecast, searched_books, total_books_found, destination)
    @id = 'null'
    @type = 'books'
    @forecast = forecast
    @searched_books = searched_books
    @total_books_found = total_books_found
    @destination = destination
  end
end
