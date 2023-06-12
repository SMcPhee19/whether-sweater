class BooksSerializer
  include JSONAPI::Serializer
  attributes :forecast, :searched_books, :total_books_found, :destination
end