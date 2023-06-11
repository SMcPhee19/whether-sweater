require 'rails_helper'

RSpec.describe GeocodeService do
  it 'returns coordinates for a location', :vcr do
    service = GeocodeService.new
    location = service.get_coordinates('Denver,CO')

    expect(location).to be_a(Hash)

    expect(location[:results][0][:locations][0][:latLng]).to be_a(Hash)
    expect(location[:results][0][:locations][0][:latLng]).to have_key(:lat)
    expect(location[:results][0][:locations][0][:latLng][:lat]).to be_a(Float)
    expect(location[:results][0][:locations][0][:latLng][:lat]).to eq(39.74001)
    expect(location[:results][0][:locations][0][:latLng]).to have_key(:lng)
    expect(location[:results][0][:locations][0][:latLng][:lng]).to be_a(Float)
    expect(location[:results][0][:locations][0][:latLng][:lng]).to eq(-104.99202)
  end
end