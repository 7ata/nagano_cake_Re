class Admin::ItemsController < ApplicationController
  def index
    @item = Item.new
    @items = Item.page(params[:page])
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
  		redirect_to admin_items_path(@item.id), notice: "商品が登録されました！."
    else
      @items = Item.all
      render :index
    end
  end
  
  def update
    @item = Item.find(params[:id])
    @genres = Genre.all
    if @item.update(item_params)
      redirect_to admin_items_path(@item)
    else
      render :edit
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end
  
  private
  def item_params
    params.require(:item).permit(:id,:genre_id,:name,:introduction,:price,:is_active)
  end
  
end
