require 'faraday'

class GetDailyForecast
  def self.get_daily_forecast
    res = Faraday.get("https://api.openweathermap.org/data/2.5/onecall?lat=36&APPID=5beca3555f713ec7c45828b27c299a8e&lon=139.839478&exclude=current,minutely,hourly,alerts")
    binding.pry
    res_body = JSON.parse(res.body)
  end
end