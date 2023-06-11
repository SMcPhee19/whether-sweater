class GeocodeService
  def get_coordinates(location)
    get_url("/geocoding/v1/address?location=#{location}")
  end

  private

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://www.mapquestapi.com') do |f|
      f.params['key'] = ENV['GEOCODER_API_KEY']
    end
  end
end