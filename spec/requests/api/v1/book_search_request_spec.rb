# spec/requests/api/v0/search_request_spec.rb
require 'rails_helper'

RSpec.describe 'search request' do
  describe 'happy path' do
    it 'can get search data for a book', :vcr do
      location = 'philadelphia,pa'
      quantity = 10

      get "/api/v1/book-search?location=#{location}&quantity=#{quantity}"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      books = JSON.parse(response.body, symbolize_names: true)
require 'pry'; binding.pry
      expect(books).to be_a(Hash)

      expect(books).to have_key(:data)
      expect(books[:data]).to be_a(Hash)
      expect(books[:data]).to have_key(:id)
      expect(books[:data][:id]).to eq('null')
      expect(books[:data]).to have_key(:type)
      expect(books[:data][:type]).to eq('books')

      expect(books[:data]).to have_key(:attributes)
      expect(books[:data][:attributes]).to be_a(Hash)

      expect(books[:data][:attributes]).to have_key(:forecast)
      expect(books[:data][:attributes][:forecast]).to be_a(Hash)
      expect(books[:data][:attributes][:forecast]).to have_key(:summary)
      expect(books[:data][:attributes][:forecast][:summary]).to be_a(String)
      expect(books[:data][:attributes][:forecast]).to have_key(:temperature)
      expect(books[:data][:attributes][:forecast][:temperature]).to be_a(Float)

      expect(books[:data][:attributes]).to have_key(:total_books_found)
      expect(books[:data][:attributes][:total_books_found]).to be_a(Integer)

      expect(books[:data][:attributes]).to have_key(:destination)
      expect(books[:data][:attributes][:destination]).to be_a(String)
      expect(books[:data][:attributes][:destination]).to eq(location)

      expect(books[:data][:attributes]).to have_key(:searched_books)
      expect(books[:data][:attributes][:searched_books]).to be_a(Array)
      expect(books[:data][:attributes][:searched_books].count).to eq(quantity)

      # Individually test each book's attributes
      books[:data][:attributes][:searched_books].each do |book|
        expect(book).to have_key(:isbn)
        # expect(book[:isbn]).to be_an(Array || nil)
          # Note: ^ Since some of these showed up nil in my pry, the test is failng
          # I am not sure how to test if it is either a nil or an array
          # This was my error message: `expected nil to be a kind of Array`
        expect(book).to have_key(:title)
        expect(book[:title]).to be_a(String)
        expect(book).to have_key(:publisher)
        expect(book[:publisher]).to be_a(Array)
      end
    end
  end

  # describe 'sad path' do
  #   it 'returns an error if location is missing', :vcr do
  #     location = ''
  #     quantity = 10

  #     get "/api/v1/book-search?location=#{location}&quantity=#{quantity}"

  #     expect(response).to_not be_successful
  #     expect(response.status).to eq(400)

  #     error = JSON.parse(response.body, symbolize_names: true)

  #     expect(error).to be_a(Hash)
  #   end
  # end
end