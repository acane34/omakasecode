class UsersController < ApplicationController
  before_action :set_user
  def edit
  end

  def update
    @user.update_without_password(user_params)
    redirect_to mypage_users_url
  end

  def withdrawal
    # deleted_flgカラムをtrueに変更することにより削除フラグを立てる
    @user.update(deleted_flg: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private
    def set_user
      @user = current_user
      @places = Place.all
    end

    def user_params
      params.permit(:username, :email, :password, :password_confirmation, :area, :age, :gender, :place_id)
    end
end
