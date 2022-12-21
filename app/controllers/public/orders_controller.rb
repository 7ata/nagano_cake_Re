class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
    @addresses = current_customer.addresses
  end

  def confirm
    @customer = current_customer
    #ここに注文情報入力の部分　条件分岐　まだcreateじゃない
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
