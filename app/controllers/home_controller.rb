class HomeController < ApplicationController
  before_action :get_weater
  def index
    # 今日の気温
    @today_temp = @hash[0]["f_temp"]
    @today_tdefference = @hash[0]["temp_defference"]
    @today_icon = @hash[0]["icon"]
  end

  def week
  end

  private
  def get_weater
    @user = current_user
    @place = Place.find(@user.place_id)
    @lat = Place.lat_and_lon(@place.id)[0]
    @lon = Place.lat_and_lon(@place.id)[1]
    @hash = GetDailyForecast.get_daily_forecast(@lat,@lon)
  end
end
