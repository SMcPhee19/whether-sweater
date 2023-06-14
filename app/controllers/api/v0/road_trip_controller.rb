class Api::V0::RoadTripController < ApplicationController
  def create
    trip = RoadTripFacade.new.get_road_trip(params[:road_trip][:origin], params[:road_trip][:destination])
    if User.find_by(api_key: params[:road_trip][:api_key])
      render json: RoadTripSerializer.new(trip), status: 201
    else
      render json: { error: 'Invalid API key' }, status: 401
    end
  end
end