class SearchSerializer
  include JSONAPI::Serializer
  attributes :current_weather, :searched_books, :total_books, :destination
end