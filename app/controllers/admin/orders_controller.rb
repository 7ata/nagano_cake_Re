class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_detail = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    @order_details = @order.order_details
    
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
