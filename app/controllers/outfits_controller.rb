class OutfitsController < ApplicationController
  def index
    @outfits = Outfit.where(user_id: current_user.id)
  end

  def show
    @outfit = Outfit.find(params[:id])
    @categories = Category.all
  end

  def new
    @outfit = Outfit.new
    @categories = Category.all
  end

  def create
    @outfit = Outfit.create!(outfit_params)
    flash[:notice] = "アイテムを登録しました"
    redirect_to outfit_url @outfit
  end

  def edit
    @outfit = Outfit.find(params[:id])
    @categories = Category.all
  end

  def update
    @outfit = Outfit.find(params[:id])
    @outfit.update!(outfit_params)
    flash[:notice] = "アイテムを編集しました"
    redirect_to outfit_url @outfit
  end

  def destroy
    @outfit = Outfit.find(params[:id])
    @outfit.destroy
    flash[:notice] = "アイテムを削除しました"
    redirect_to outfits_url
  end

  private
    def outfit_params
      params.require(:outfit).permit(:name, :description, :major_color, :sub_color, :tone, :user_id, :category_id, :always, :spring, :summer, :autum, :winter, :image )
    end
end
