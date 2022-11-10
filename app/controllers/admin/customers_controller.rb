class Admin::CustomersController < ApplicationController
  def index
    @customer = Customer.new
    @customers = Customer.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    #@orders = Oder.all
    if @customer.update(customer_params)
      redirect_to admin_customers_path(@customer),notice: "User was successfully updated."
    else
      render :edit
    end
  end

  private
  def customer_params
    params.require(:customer).permit(:last_name,:fast_name,:last_name_kana,
    :fast_name_kana,:email,:postal_code,:address,:telephone_number,:is_deleted)
  end
end
