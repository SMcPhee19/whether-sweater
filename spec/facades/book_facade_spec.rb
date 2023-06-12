require 'rails_helper'

RSpec.describe 'book facade' do
  it 'can get book data', :vcr do
    location = 'Denver,CO'
    quantity = 5

    expect(BookFacade.new.search_books(location, quantity)).to be_a(Array)
  end
end