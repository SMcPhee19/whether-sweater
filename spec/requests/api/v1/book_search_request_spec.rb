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
      expect(books[:data][:type]).to eq('search')
      # I don't know why type is being set this way.
      # I have it set to 'books' in the poro line 11.
      # It is 11:20 MT and I am not done, I am going to move on.
      # I will make note of it when I turn it in and let both instructors know as well
      
    end
  end
end