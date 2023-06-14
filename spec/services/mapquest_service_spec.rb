require 'rails_helper'

RSpec.describe MapquestService do
  describe 'geocoding' do
    it 'returns coordinates for a location', :vcr do
      service = MapquestService.new
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

  describe 'directions' do
    it 'returns directions for a road trip', :vcr do
      service = MapquestService.new
      start = 'san francisco,ca'
      destination = 'boston,ma'
      directions = service.get_directions(start, destination)

      expect(directions).to be_a(Hash)

      expect(directions[:route]).to be_a(Hash)
      expect(directions[:route]).to have_key(:locations)
      expect(directions[:route][:locations]).to be_an(Array)
      expect(directions[:route][:locations][0]).to be_a(Hash)
      expect(directions[:route][:locations][0]).to have_key(:adminArea5)
      expect(directions[:route][:locations][0][:adminArea5]).to be_a(String)
      expect(directions[:route][:locations][0][:adminArea5]).to eq('San Francisco')
      expect(directions[:route][:locations][1]).to be_a(Hash)
      expect(directions[:route][:locations][1]).to have_key(:adminArea5)
      expect(directions[:route][:locations][1][:adminArea5]).to be_a(String)
      expect(directions[:route][:locations][1][:adminArea5]).to eq('Boston')

      # hash contains destination lat lon for weather in destination city
      expect(directions[:route][:locations][1]).to have_key(:latLng)
      expect(directions[:route][:locations][1][:latLng]).to be_a(Hash)
      expect(directions[:route][:locations][1][:latLng]).to have_key(:lat)
      expect(directions[:route][:locations][1][:latLng][:lat]).to be_a(Float)
      expect(directions[:route][:locations][1][:latLng][:lat]).to eq(42.35866)
      expect(directions[:route][:locations][1][:latLng]).to have_key(:lng)
      expect(directions[:route][:locations][1][:latLng][:lng]).to be_a(Float)
      expect(directions[:route][:locations][1][:latLng][:lng]).to eq(-71.05674)
    end
  end
end