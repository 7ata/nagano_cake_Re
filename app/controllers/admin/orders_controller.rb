class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Customer.find(params[:id])
    #@orders = Oder.all
    if @order.update(order_params)
      redirect_to admin_orders_show_path(@order),notice: "User was successfully updated."
    else
      render :show
    end
  end

  def order_params
    params.require(:order).permit(:id,:name,:address,:status)
  end
end
