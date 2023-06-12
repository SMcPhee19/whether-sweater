require 'rails_helper'

RSpec.describe 'book facade' do
  it 'can get book data', :vcr do
    location = 'Denver,CO'
    quantity = 5

    search = BookFacade.new.search_books(location, quantity)

    # require 'pry'; binding.pry
    expect(search).to be_a(Search)
    expect(search.id).to eq(nil)
    expect(search.type).to eq('books')
    expect(search.current_weather).to be_a(Hash)
    expect(search.searched_books).to be_a(Array)
    expect(search.total_books).to be_an(Integer)
    expect(search.destination).to be_a(String)
  end
end