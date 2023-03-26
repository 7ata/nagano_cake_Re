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
		  @address = Address.find(params[:order][:customer_id])
		  #orderのcustomer_id(=カラム)でアドレス(帳)を選び、そのデータ送る
		  #params[:order][:address_option] == "0"から"2"の 住所データを定義する
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    # 新規住所入力 [:address_option]=="2"としてデータをhtmlから受ける
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
    @order.customer_id = current_customer.id
    @order.status = 0
    @order.save

    # order_detailsの保存
    current_customer.cart_items.each do |cart_item| #カートの商品を1つずつ取り出しループ
      @order_detail = OrderDetail.new #初期化宣言
      @order_detail.order_id =  @order.id #注文商品に注文idを紐付
      @order_detail.item_id = cart_item.item_id #商品idを注文商品idに代入
      @order_detail.amount = cart_item.amount #商品の個数を注文商品の個数に代入
      @order_detail.price = cart_item.item.with_tax_price #消費税込みに計算して代入
      @order_detail.making_status = 0
      @order_detail.save #注文商品を保存
    end

      current_customer.cart_items.destroy_all #カートの中身を削除
        redirect_to orders_complete_path
  end

  def index
    @orders = current_customer.orders

  end

  def show
    @order = current_customer.orders.find(params[:id])
    #@order_details = @order.order_details
  end

  private
  def order_params
  params.require(:order).permit(:id,:payment_method,:postal_code, :address, :name,
  :satus,:total_payment,:shipping_cost,:customer_id,:created_at,:updated_at)
  end
end
