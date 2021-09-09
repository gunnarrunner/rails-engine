class Api::V1::MerchantsController < ApplicationController
  def index
    if params[:page].to_i <= 0
      page = 1
      per_page = params.fetch(:per_page, 20).to_i
      merchants = Merchant.offset((page - 1) * per_page).limit(per_page)
      render json: MerchantSerializer.new(merchants)
    else
      page = params.fetch(:page, 1).to_i
      per_page = params.fetch(:per_page, 20).to_i
      merchants = Merchant.offset((page - 1) * per_page).limit(per_page)
      render json: MerchantSerializer.new(merchants)
    end
  end

  def show
      merchant = Merchant.find(params[:id])
      render json: MerchantSerializer.new(merchant)
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