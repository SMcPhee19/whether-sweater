require 'rails_helper'

RSpec.describe BookService do
  it 'returns books for a location', :vcr do
    service = BookService.new
    location = service.get_books('Denver,CO')

    expect(location).to be_a(Hash)
    expect(location[:numFound]).to be_an(Integer)
  end
end