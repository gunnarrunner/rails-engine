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

#   def new
    
#   end

#   def create
    
#   end

#   def edit
    
#   end

#   def update
    
#   end

#   def destroy
    
#   end
  
# private
#   def _params
#     params.permit(:)
#   end
end