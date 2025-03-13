class ItemsController < ApplicationController
  def index
    breeds = params[:options]
    if params[:options] == nil || breeds.length == 0
      items = Item.order("RANDOM()")
    else
      items = Item.joins(:breed).where(breeds: { name: breeds }).order("RANDOM()")
    end
    @items= items.paginate(page: params[:page], per_page: 11)
  end

  def show
    @item = Item.find(params[:id])
  end
end
