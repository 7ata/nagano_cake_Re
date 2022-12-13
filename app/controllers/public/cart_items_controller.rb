class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
    @total = 0

  end

  def create

    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id

    if @cart_item.save
  		redirect_to cart_items_path, notice: "商品をカートに入れました"
    else
      @cart_items = CartItem.all
      render :index
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to cart_items_path, notice: "数量を変更しました"
   else
      render :index
   end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])  # データ（レコード）を1件取得
    if @cart_item.destroy  # データ（レコード）を削除
      redirect_to cart_items_path, notice: "カート内商品を1件削除しました！"
    end
  end

  def destroy_all
    @cart_item = current_customer.cart_items
    if @cart_item.destroy_all
      redirect_to cart_items_path, notice: "カート内商品を全て削除しました！"
    end
  end

  private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end
end
