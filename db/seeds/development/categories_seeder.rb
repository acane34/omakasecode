categories = ["トップス","ボトムス", "スカート", "ワンピース", "アウター","靴", "小物","かばん", "アクセサリー"]

  categories.each do |category|
    Category.create!(
      name: category
    )
  end