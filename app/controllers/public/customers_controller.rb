class Public::CustomersController < ApplicationController
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
      redirect_to customer_path(@customer.id),notice: "変更内容を保存しました!"
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
  end

  private
  def customer_params
    params.require(:customer).permit(:last_name,:fast_name,:last_name_kana,
    :fast_name_kana,:email,:postal_code,:address,:telephone_number,:is_deleted)
  end
end
