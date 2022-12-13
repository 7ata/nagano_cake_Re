class Public::AddressesController < ApplicationController
  def index
    @customer = current_customer
    @address = Address.new
    @addresses = @customer.addresses
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    # 3. データをデータベースに保存するためのsaveメソッド実行
   if @address.save
  		redirect_to addresses_path(@address.id), notice: "配送先が登録されました！"
   else
      @addresses = @customer.addresses
      @customer = current_customer
      render :index
   end

  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
   if @address.update(address_params)
      redirect_to addresses_path(@address.id), notice: "配送先を更新しました！"
   else
      render :edit
   end
  end


  def destroy
    @address = Address.find(params[:id])  # データ（レコード）を1件取得
   if @address.destroy  # データ（レコード）を削除
    redirect_to addresses_path, notice: "配送先を削除しました！"# 投稿一覧画面へリダイレクト
   end
  end

   private
  def address_params
    params.require(:address).permit(:customer_id,:name,:postal_code,:address)
  end
end
