require 'rails_helper'

RSpec.describe 'road trip facade' do
  it 'can get road trip data', :vcr do
    trip = RoadTripFacade.new.get_road_trip('seattle,wa', 'bangor,me')

    expect(trip).to be_a(RoadTrip)
    expect(trip.id).to eq('null')
    expect(trip.type).to eq('roadtrip')
    expect(trip.start_city).to be_a(String)
    expect(trip.start_city).to eq('seattle,wa')
    expect(trip.end_city).to be_a(String)
    expect(trip.end_city).to eq('bangor,me')
    expect(trip.travel_time).to be_a(String)
    expect(trip.travel_time).to eq('45:34:12')
    expect(trip.weather_at_eta).to be_a(Hash)
    expect(trip.weather_at_eta).to have_key(:temperature)
    expect(trip.weather_at_eta[:temperature]).to be_a(Float)
    expect(trip.weather_at_eta).to have_key(:conditions)
    expect(trip.weather_at_eta[:conditions]).to be_a(String)
    expect(trip.weather_at_eta).to have_key(:datetime)
    expect(trip.weather_at_eta[:datetime]).to be_a(String)
  end

  it 'road trip - sad path - impossible route', :vcr do
    trip = RoadTripFacade.new.get_road_trip('seattle,wa', 'london,uk')

    expect(trip).to be_a(RoadTrip)
    expect(trip.id).to eq('null')
    expect(trip.type).to eq('roadtrip')
    expect(trip.start_city).to be_a(String)
    expect(trip.start_city).to eq('seattle,wa')
    expect(trip.end_city).to be_a(String)
    expect(trip.end_city).to eq('london,uk')
    expect(trip.travel_time).to be_a(String)
    expect(trip.travel_time).to eq('impossible route')
    expect(trip.weather_at_eta).to eq({})
  end
end