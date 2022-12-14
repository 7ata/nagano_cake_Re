class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
    @total = 0

  end

  def create

    #@cart_item = CartItem.new(cart_item_params)
    @cart_item = current_customer.cart_items.new(cart_item_params)
        # もし元々カート内に「同じ商品」がある場合、「数量を追加」更新・保存する
    @cart_item.customer_id = current_customer.id

    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      #元々カート内にあるもの「item_id」
                          #今追加した　　　　　　　params[:cart_item][:item_id])

       cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
            cart_item.amount += params[:cart_item][:amount].to_i
            #cart_item.amountに今追加したparams[:cart_item][:amount]を加える
                                                              #.to_iとして数字として扱う

       cart_item.save
            redirect_to cart_items_path, notice: "商品の数を追加しました"

    # もしカート内に「同じ」商品がない場合は通常の保存処理
    elsif @cart_item.save
  		redirect_to cart_items_path, notice: "商品をカートに入れました"

    else# 保存できなかった場合
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
      params.require(:cart_item).permit(:item_id, :amount,:customer_id)
  end
end
