class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    merchant_items = Merchant.find(params[:merchant_id]).items
    render json: ItemSerializer.new(merchant_items)
      rescue ActiveRecord::RecordNotFound
    render status: 404
  end

#   def show
    
#   end
  
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