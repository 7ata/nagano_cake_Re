class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
    @addresses = current_customer.addresses.all
  end

  def confirm
    @order = Order.new(order_params)
    #ここに注文情報入力の部分 条件分岐 まだcreateじゃない
    @cart_items = current_customer.cart_items.all
    @total = 0
		@order.payment_method = params[:order][:payment_method]

    if params[:order][:address_option] == "0"#ご自身の住所選択時
		  @order.postal_code = current_customer.postal_code
			@order.address = current_customer.address
			@order.name = current_customer.fast_name + current_customer.last_name

		elsif params[:order][:address_option] == "1"#登録済み住所から選択
		  @address = Address.find(params[:order][:registered])
		  #orderのaddress_id(=カラム)でアドレス(帳)を選び、そのデータ送る
		  #params[:order][:address_option] == "0"から"2"の 住所データを定義する
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name

    elsif params[:order][:address_option] = "2"#新しいお届け先選択
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    else
          render 'new'
    end


  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    @order.save
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
