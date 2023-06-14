class RoadTripFacade
  def get_road_trip(start, destination)
    trip = road_trip_service.get_directions(start, destination)
    start_city = start
    end_city = destination

    if trip[:info][:statuscode] == 402
      RoadTrip.new(start_city, end_city, 'impossible route', {})
    else
      travel_time = trip[:route][:realTime]
      formatted_travel_time = trip[:route][:formattedTime]
      arrival_time = Time.now + travel_time
      formatted_arrival_time = arrival_time.strftime('%Y-%m-%d %H:%M')
      dest_lat = trip[:route][:locations][1][:latLng][:lat]
      dest_lon = trip[:route][:locations][1][:latLng][:lng]
      arrival_weather = weather_service.get_daily(dest_lat, dest_lon)

      arrival_weather[:forecast][:forecastday].map do |day|
        next unless arrival_time.to_s.include?(day[:date])
        @weather_at_eta = {
          datetime: formatted_arrival_time,
          temperature: day[:hour][arrival_time.hour][:temp_f],
          conditions: day[:hour][arrival_time.hour][:condition][:text]
        }
      end
      RoadTrip.new(start_city, end_city, formatted_travel_time, @weather_at_eta)
    end
  end

  def road_trip_service
    @_road_trip ||= MapquestService.new
  end

  def weather_service
    @_weather_service ||= WeatherService.new
  end
end