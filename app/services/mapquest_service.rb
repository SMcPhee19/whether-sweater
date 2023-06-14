class MapquestService
  def get_coordinates(location)
    get_url("/geocoding/v1/address?location=#{location}")
  end

  def get_directions(start, destination)
    get_url("/directions/v2/route?from=#{start}&to=#{destination}")
  end

  private

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://www.mapquestapi.com') do |f|
      f.params['key'] = ENV['MAPQUEST_API_KEY']
    end
  end
end
