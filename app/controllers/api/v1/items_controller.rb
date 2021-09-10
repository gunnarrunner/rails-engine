class Api::V1::ItemsController < ApplicationController
  def index
    if params[:page].to_i <= 0
      page = 1
      per_page = params.fetch(:per_page, 20).to_i
      items = Item.offset((page - 1) * per_page).limit(per_page)
      render json: ItemSerializer.new(items)
    else
      page = params.fetch(:page, 1).to_i
      per_page = params.fetch(:per_page, 20).to_i
      items = Item.offset((page - 1) * per_page).limit(per_page)
      render json: ItemSerializer.new(items)
    end
  end

  def show
      item = Item.find(params[:id])
      render json: ItemSerializer.new(item)
        rescue ActiveRecord::RecordNotFound
      render status: 404
  end

  def create
    item = Item.new(item_params)

    if item.save
      render json: ItemSerializer.new(item), status: 201
    else
      render status: 404
    end
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      render json: ItemSerializer.new(item)
    else
      render status: 404
    end
      rescue ActiveRecord::RecordNotFound
    render status: 404
  end

  def destroy
    item = Item.find(params[:id])
    render json: item.delete, status: 204
      rescue ActiveRecord::RecordNotFound
    render status: 404
  end
  
private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end