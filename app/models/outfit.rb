class Outfit < ApplicationRecord
  belongs_to :user
  belongs_to :category
  mount_uploader :image, ImageUploader

  # scope :searchbottoms, -> {select{|a| (a.category_id==2)||(a.category_id==3)}}
  # scope :searchtops, -> {select{|a| (a.category_id==1)}}

  SPRING_MAX = 30
  SPRING_MIN = 15
  SUMMER_MIN = 21
  AUTUM_MAX = 28
  AUTUM_MIN = 12
  WINTER_MAX = 15

  # OUTER_TENP = 15
  # OUTER_DIF = 7


  # 先に決まっているアイテムをpre、候補アイテム全てをcandiとする　返り値は、条件に合うアイテムのリスト

  # 同一色相配色
  def self.same_color_select(pre,candi)
    # 先に決まっているものが白黒なら何も考えない
    if pre.major_color.to_i == 0 || pre.major_color.to_i == 13
      return candi
    else
      nextlist = []
      candi.each do |c|
        # 考察中のものが白黒なら何も考えない
        if c.major_color.to_i == 0 || c.major_color.to_i == 13
          nextlist.push c
        elsif c.major_color.to_i == pre.major_color.to_i
          nextlist.push c
        end
      end
      return nextlist
    end
  end

  # 類似色相配色
  def self.similar_color_select(pre,candi)
    # 先に決まっているものが白黒なら何も考えない
    if pre.major_color.to_i == 0 || pre.major_color.to_i == 13
      return candi
    else
      nextlist = []
      candi.each do |c|
        # 考察中のものが白黒なら何も考えない
        if c.major_color.to_i == 0 || c.major_color.to_i == 13
          nextlist.push c
        elsif (c.major_color.to_i % 12 - pre.major_color.to_i).abs == 1
          nextlist.push c
        end
      end
      return nextlist
    end
  end

  # 同一トーン配色
  def self.same_tone_select(pre,candi)
  # v, b, dp, sf, d, p, dkg　の対応関係
    # 白黒なら何も考えない
    if pre.major_color.to_i == 0 || pre.major_color.to_i == 13
      return candi
    else
      nextlist = []
      candi.each do |c|
        # 白黒なら何も考えない
        if c.major_color.to_i == 0 || c.major_color.to_i == 13
          nextlist.push c
        elsif  pre.tone == "v" # vの時
          if c.tone == "v"
            nextlist.push c
          end
        elsif  pre.tone == "b" # bの時
          if c.tone == "b"
            nextlist.push c
          end 
        elsif  pre.tone == "dp" # dpの時
          if c.tone == "dp"
            nextlist.push c
          end 
        elsif  pre.tone == "sf" # sfの時
          if c.tone == "sf"
            nextlist.push c
          end
        elsif  pre.tone == "d" # dの時
          if c.tone == "d"
            nextlist.push c
          end
        elsif  pre.tone == "p" # pの時
          if c.tone == "p"
            nextlist.push c
          end
        elsif  pre.tone == "dkg" # dkgの時
          if c.tone == "dkg"
            nextlist.push c
          end
        end
      end
      return nextlist
    end
  end

  # 類似トーン配色
  def self.similar_tone_select(pre,candi)
  # v, b, dp, sf, d, p, dkg　の対応関係
    # 白黒なら何も考えない
    if pre.major_color.to_i == 0 || pre.major_color.to_i == 13
      return candi
    else
      nextlist = []
      candi.each do |c|
        # 白黒なら何も考えない
        if c.major_color.to_i == 0 || c.major_color.to_i == 13
          nextlist.push c
        elsif  pre.tone == "v" # vの時 b,dp
          if c.tone == "b" || c.tone.to_i == "dp"
            nextlist.push c
          end
        elsif  pre.tone == "b" # bの時 v,dp,sf
          if c.tone == "v" || c.tone.to_i == "dp" || c.tone.to_i == "sf"
            nextlist.push c
          end 
        elsif  pre.tone == "dp" # dpの時 v,b,d
          if c.tone == "v" || c.tone == "b" || c.tone.to_i == "d"
            nextlist.push c
          end 
        elsif  pre.tone == "sf" # sfの時 b,d,p
          if c.tone == "b" || c.tone.to_i == "d" || c.tone.to_i == "p"
            nextlist.push c
          end
        elsif  pre.tone == "d" # dの時 dp,sf,dkg
          if c.tone == "dp" || c.tone == "sf" || c.tone.to_i == "dkg"
            nextlist.push c
          end
        elsif  pre.tone == "p" # pの時 sf,dkg
          if c.tone == "sf" || c.tone.to_i == "dkg"
            nextlist.push c
          end
        elsif  pre.tone == "dkg" # dkgの時 d,p
          if c.tone == "d" || c.tone == "p"
            nextlist.push c
          end
        end
      end
      return nextlist
    end
  end

  # 対照色相配色　補色色相配色
  def self.contrast_color_select(pre,candi)
    # 先に決まっているものが白黒なら何も考えない
    if pre.major_color.to_i == 0 || pre.major_color.to_i == 13
      return candi
    else
      nextlist = []
      candi.each do |c|
        # 考察中のものが白黒なら何も考えない
        if c.major_color.to_i == 0 || c.major_color.to_i == 13
          nextlist.push c
        elsif (c.major_color.to_i - pre.major_color.to_i).abs > 3 && (c.major_color.to_i - pre.major_color.to_i).abs < 9
          nextlist.push c
        end
      end
      return nextlist
    end
  end


  # 対照トーン配色
  def self.contrast_tone_select(pre,candi)
    # v, b, dp, sf, d, p, dkg　の対応関係
      # 白黒なら何も考えない
      if pre.major_color.to_i == 0 || pre.major_color.to_i == 13
        return candi
      else
        nextlist = []
        candi.each do |c|
          # 白黒なら何も考えない
          if c.major_color.to_i == 0 || c.major_color.to_i == 13
            nextlist.push c
          elsif  pre.tone == "v" # vの時
            if c.tone == "v" || c.tone == "p" || c.tone == "dkg"
              nextlist.push c
            end
          elsif  pre.tone == "b" # bの時
            if c.tone == "dp" || c.tone == "dkg" || c.tone == "p"
              nextlist.push c
            end 
          elsif  pre.tone == "dp" # dpの時
            if c.tone == "b" || c.tone == "p" || c.tone == "dkg"
              nextlist.push c
            end 
          elsif  pre.tone == "p" # pの時
            if c.tone == "dp" || c.tone == "dkg" || c.tone == "b" || c.tone == "v"
              nextlist.push c
            end
          elsif  pre.tone == "dkg" # dkgの時
            if c.tone == "p" || c.tone == "b" || c.tone == "dp" || c.tone == "v"
              nextlist.push c
            end
          end
        end
        return nextlist
      end
  end

  # その日の気温をtemp、気温差をtemp_dif、候補のアイテムのリストをcandi
  def self.season_select(temp,temp_dif,candi)
    current_month = Date.today.month
    nextlist = []
    candi.each do |c|
      if c.always == true
        nextlist.push c
      elsif c.spring == true
        if temp > SPRING_MIN && temp < SPRING_MAX && current_month > 2 && current_month < 7
          nextlist.push c
        end
      elsif c.summer == true
        if temp > SUMMER_MIN && current_month > 5 && current_month < 10
          nextlist.push c
        end
      elsif c.autum == true
        if temp > AUTUM_MIN && temp < AUTUM_MAX && current_month > 8 && current_month < 12
          nextlist.push c
        end
      elsif c.winter == true
        if temp < WINTER_MAX && (current_month > 10 || current_month < 4)
          nextlist.push c
        end
      end
    end
    return nextlist
  end
end
