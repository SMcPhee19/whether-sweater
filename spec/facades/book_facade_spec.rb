require 'rails_helper'

RSpec.describe 'book facade' do
  it 'can get book data', :vcr do
    location = 'Denver,CO'
    quantity = 5

    search = BookFacade.new.search_books(location, quantity)

    expect(search).to be_a(Books)
    expect(search.id).to eq('null')
    expect(search.type).to eq('books')
    expect(search.forecast).to be_a(Hash)
    expect(search.searched_books).to be_a(Array)
    expect(search.total_books_found).to be_an(Integer)
    expect(search.destination).to be_a(String)
  end
end