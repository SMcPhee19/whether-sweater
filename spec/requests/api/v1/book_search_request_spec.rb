# spec/requests/api/v0/search_request_spec.rb
require 'rails_helper'

RSpec.describe 'search request' do
  describe 'happy path' do
    it 'can get search data for a book', :vcr do
      location = 'Denver,CO'
      quantity = 5

      get "/api/v1/book-search?location=#{location}&quantity=#{quantity}"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      books = JSON.parse(response.body, symbolize_names: true)

      require 'pry'; binding.pry
    end
  end
end