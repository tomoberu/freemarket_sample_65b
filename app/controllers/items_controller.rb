class ItemsController < ApplicationController

  layout 'devise', only: [:new, :buy_confirmation]

  before_action :set_user, only: [:exhibiting, :trading, :sold]

  def index
    @items = Item.all.joins(:photos).group("item_id").order('id DESC')

  end

  def new
    @item = Item.new
    @item.photos.new
    @item.brands.new
  end

  def show
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to new_item_path
    else
      render new_user_path
    end
  end

  def exhibiting
    @buyedphotos = @item.buyed_items
  end

  def trading
    @sellingitem = @item.selling_items
  end

  def sold
    @solditem = @item.sold_items
  end

  def get_delivery_method
  end 

  def edit
  end

  def update
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to root_path
  end

  def buy_confirmation
    if @card.blank?
      #登録された情報がない場合にカード登録画面に移動
      redirect_to controller: "cards", action: "new"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(@card.customer_id)
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  def exhibiting
  end

  def sold
  end

  def trading
  end

end

private

  def item_params
    params.require(:item).permit(:name, :description, :price, :text, :brand, :condition, :delivery_fee, :prefecture_id, :shipping_days, :shipping_area, :price, :categoryname, :user_id, photos_attributes: [:image], brands_attributes: [:brandname]).merge(user_id: current_user.id)
  end

  def set_user
    @user = User.find(params[:id])
  end
