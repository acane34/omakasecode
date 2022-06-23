user = User.new(:username => "akane",
                :email => "User@mailaddress.com",
                :deleted_flg => false,
                :place_id => 1,
                :password =>   "password"
                )
user.skip_confirmation!
user.save!