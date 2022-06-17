require 'faraday'

class GetDailyForecast
  def self.get_daily_forecast(lat,lon)
    res = Faraday.get("https://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&APPID=#{ENV["OPEN_WEATHER_API_KEY"]}&lon=#{lon}&exclude=current,minutely,hourly,alerts")
    res_body = JSON.parse(res.body)
    forecasts = res_body["daily"]
    result = []

    forecasts.each do |forecast|
      daily_result = {}
      daily_result["date"] = DateTime.strptime("#{forecast["dt"]}",'%s').to_time
      daily_result["f_temp"] = (forecast["feels_like"]["day"]-273).to_i
      daily_result["f_m"] = (forecast["feels_like"]["morn"]-273).to_i
      daily_result["f_n"] = (forecast["feels_like"]["night"]-273).to_i
      daily_result["temp_defference"] = ((forecast["feels_like"]["day"]-273).to_i  - (forecast["feels_like"]["morn"]-273).to_i).abs
      daily_result["weather_id"] = forecast["weather"][0]["id"]
      daily_result["weather"] = forecast["weather"][0]["main"]
      daily_result["detail_weather"] = forecast["weather"][0]["description"]
      daily_result["icon"] = forecast["weather"][0]["icon"]+".png"
      result.push(daily_result)
    end
    return result
  end
end