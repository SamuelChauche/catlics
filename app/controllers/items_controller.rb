class ItemsController < ApplicationController
  def index
    breeds = params[:options]
    p "#"*111
    if params[:options] == nil || breeds.length == 0
      items = Item
    else
      items = Item.joins(:breed).where(breeds: { name: breeds })
    end
    if params[:sort] == "price_asc"
      items = items.order(price: :asc)
    elsif params[:sort] == "price_desc"
      items = items.order(price: :desc)
    elsif params[:sort] == "random"
      items = items.order("RANDOM()")
    end
    @items= items.paginate(page: params[:page], per_page: 11)
  end

  def show
    @item = Item.find(params[:id])
  end
end
