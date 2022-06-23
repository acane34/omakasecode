class HomeController < ApplicationController
  before_action :get_weater
  before_action :get_outfits
  
  def index
    # 今日の気温
    @today_temp = @forecast[0]["f_temp"]
    @today_tdefference = @forecast[0]["temp_defference"]
    @today_icon = @forecast[0]["icon"]

    # おすすめコーデロジック
    season_selected_outfits = Outfit.season_select(@today_temp,@today_tdefference,@outfits) # 気温で篩をかける

    base = season_selected_outfits.select{|a| (a.category_id ==1)||(a.category_id ==2)||(a.category_id ==3)||(a.category_id ==4)} # 1:上、下、上下の中から、一つアイテムを選ぶ
    if base
      @basecode = []
      # ランダムに一つ選びます
      base1 = base[rand(base.length)]
      @basecode.push base1
      if base1.category_id == 1 # トップスの時
        basebottoms = season_selected_outfits.select{|a| (a.category_id==2)||(a.category_id==3)}
        @basecode.push select_baseitems_by_color(base1,basebottoms)
      elsif base1.category_id == 2 || base1.category_id == 3 # ボトムス、スカートの時
        basetops = season_selected_outfits.select{|a| (a.category_id==1)}
        @basecode.push select_baseitems_by_color(base1,basetops)
      end
    else
      @appology = "アイテムが少ないので、コーデを完成できません"
    end

    # 小物を選ぶ　小物、靴、鞄、アクセサリー
    accessories = season_selected_outfits.select{|a| a.category_id==9} # アクセサリーは何でも良い
    @accessory = accessories[rand(accessories.length)]
    #　もとにする色は、base1
    shoes = season_selected_outfits.select{|a| a.category_id==6}
    @shoes = select_otheritems_by_color(base1,shoes)
    items = season_selected_outfits.select{|a| a.category_id==7}
    @item = select_otheritems_by_color(base1,items)
    bags = season_selected_outfits.select{|a| a.category_id==8}
    @bag = select_otheritems_by_color(base1,bags)
    outers = season_selected_outfits.select{|a| a.category_id==5}
    selecter_outer = (Outfit.same_color_select(base1,outers) + Outfit.similar_color_select(base1,outers) + Outfit.same_tone_select(base1,outers) + Outfit.similar_tone_select(base1,outers) + Outfit.contrast_color_select(base1,outers) + Outfit.contrast_tone_select(base1,outers) ).uniq
    @outer = selecter_outer[rand(selecter_outer.length)]
    @items = []
    @items.push @outer
    @items.push @accessory
    @items.push @shoes
    @items.push @item
    @items.push @bag
    
  end

  def week1
    weekly_code(0)
  end
  def week2
    weekly_code(1)
  end
  def week3
    weekly_code(2)
  end
  def week4
    weekly_code(3)
  end
  def week5
    weekly_code(4)
  end
  def week6
    weekly_code(5)
  end
  def week7
    weekly_code(6)
  end
  def week8
    weekly_code(7)
  end


  private
  def get_weater
    @place = Place.find_by(id: current_user.place_id)
    lat = Place.lat_and_lon(@place.id)[0]
    lon = Place.lat_and_lon(@place.id)[1]
    @forecast = GetDailyForecast.get_daily_forecast(lat,lon)
  end

  def get_outfits
    @outfits = Outfit.where(user_id: current_user.id) # outfits全て
  end

  def select_baseitems_by_color(base,candi)
    color_tone_selected_baseitems = (Outfit.same_color_select(base,candi) + Outfit.similar_color_select(base,candi) + Outfit.same_tone_select(base,candi) + Outfit.similar_tone_select(base,candi)).uniq
    return color_tone_selected_baseitems[rand(color_tone_selected_baseitems.length)]
  end

  def select_otheritems_by_color(base,candi)
    color_tone_selected_items = (Outfit.contrast_color_select(base,candi) + Outfit.contrast_tone_select(base,candi)).uniq
    return color_tone_selected_items[rand(color_tone_selected_items.length)]
  end

  def weekly_code(day)
    # 気温の取得
    temp = @forecast[day]["f_temp"]
    temp_def = @forecast[day]["temp_defference"]

    # おすすめコーデロジック
    weekly_season_selected_outfits = Outfit.season_select(temp,temp_def,@outfits) # 気温で篩をかける

    weekly_base = weekly_season_selected_outfits.select{|a| (a.category_id ==1)||(a.category_id ==2)||(a.category_id ==3)||(a.category_id ==4)} # 1:上、下、上下の中から、一つアイテムを選ぶ
    if weekly_base
      @weekly_basecode = []
      # ランダムに一つ選びます
      weekly_base1 = weekly_base[rand(weekly_base.length)]
      @weekly_basecode.push weekly_base1
      if weekly_base1.category_id == 1 # トップスの時
        weekly_basebottoms = weekly_season_selected_outfits.select{|a| (a.category_id==2)||(a.category_id==3)}
        @weekly_basecode.push select_baseitems_by_color(weekly_base1,weekly_basebottoms)
      elsif weekly_base1.category_id == 2 || weekly_base1.category_id == 3 # ボトムス、スカートの時
        weekly_basetops = weekly_season_selected_outfits.select{|a| (a.category_id==1)}
        @weekly_basecode.push select_baseitems_by_color(weekly_base1,weekly_basetops)
      end
    else
      @appology = "アイテムが少ないので、コーデを完成できません"
    end
    
    # 小物を選ぶ　小物、靴、鞄、アクセサリー
    weekly_accessories = weekly_season_selected_outfits.select{|a| a.category_id==9} # アクセサリーは何でも良い
    @weekly_accessory = weekly_accessories[rand(weekly_accessories.length)]
    #　もとにする色は、base1
    weekly_shoes = weekly_season_selected_outfits.select{|a| a.category_id==6}
    @weekly_shoes = select_otheritems_by_color(weekly_base1,weekly_shoes)
    weekly_items = weekly_season_selected_outfits.select{|a| a.category_id==7}
    @weekly_item = select_otheritems_by_color(weekly_base1,weekly_items)
    weekly_bags = weekly_season_selected_outfits.select{|a| a.category_id==8}
    @weekly_bag = select_otheritems_by_color(weekly_base1,weekly_bags)
    weekly_outers = weekly_season_selected_outfits.select{|a| a.category_id==5}
    weekly_selected_outer = (Outfit.same_color_select(weekly_base1,weekly_outers) + Outfit.similar_color_select(weekly_base1,weekly_outers) + Outfit.same_tone_select(weekly_base1,weekly_outers) + Outfit.similar_tone_select(weekly_base1,weekly_outers) + Outfit.contrast_color_select(weekly_base1,weekly_outers) + Outfit.contrast_tone_select(weekly_base1,weekly_outers) ).uniq
    @weekly_outer = weekly_selected_outer[rand(weekly_selected_outer.length)]
    @weekly_items = []
    @weekly_items.push @weekly_outer
    @weekly_items.push @weekly_accessory
    @weekly_items.push @weekly_shoes
    @weekly_items.push @weekly_item
    @weekly_items.push @weekly_bag
  end
end
