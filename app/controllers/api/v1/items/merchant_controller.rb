class Api::V1::Items::MerchantController < ApplicationController
  def index
    item_merchant = Item.find(params[:item_id]).merchant
    render json: MerchantSerializer.new(item_merchant)
      rescue ActiveRecord::RecordNotFound
    render status: 404
  end

#   def show
    
#   end
  
#   def create
    
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