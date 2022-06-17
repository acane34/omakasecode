class HomeController < ApplicationController
  before_action :get_weater
  
  def index
    # 今日の気温
    @today_temp = @forecast[0]["f_temp"]
    @today_tdefference = @forecast[0]["temp_defference"]
    @today_icon = @forecast[0]["icon"]
  end

  def week
  end

  private
  def get_weater
    @place = Place.find_by(id: current_user.place_id)
    lat = Place.lat_and_lon(@place.id)[0]
    lon = Place.lat_and_lon(@place.id)[1]
    @forecast = GetDailyForecast.get_daily_forecast(lat,lon)
  end
end
