class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
    @addresses = current_customer.addresses
  end

  def confirm
    @order = Order.new(order_params)
    #ここに注文情報入力の部分　条件分岐　まだcreateじゃない
    @cart_items = current_end_user.cart_items
		@order.payment = params[:order][:payment]
		if params[:order][:address_option] == "0"#ご自身の住所選択時
		  @order.postal_code = current_customer.postal_code
			@order.address = current_customer.address
			@order.name = current_customer.fast_name + current_customer.last_name
		elsif params[:order][:address_option] == "1"#登録済み住所から選択
		  @address = Address.find(params[:order][:address_id])
		  #orderの_id(=カラム)でアドレス(帳)を選び、そのデータ送る
      @order.postal_code = @address.post_code
      @order.address = @address.address
      @order.name = @address.name
    elsif






  end

  def complete
  end

  def create
  end

  def index
  end

  def show
  end

  private
  def order_params
  params.require(:order).permit(:payment_method,:postal_code, :address, :name)
  end
end
