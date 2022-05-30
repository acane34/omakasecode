require 'faraday'

class GetCurrentWeather
  def self.get_current_weather
    res = Faraday.get("http://api.openweathermap.org/data/2.5/weather?q=Tokyo&APPID=5beca3555f713ec7c45828b27c299a8e")
    binding.pry
    res_body = JSON.parse(res.body)
  end
end