require 'rails_helper'

RSpec.describe "Items API", type: :request do

  describe 'POST /items' do
    it 'can create an item with no errors' do
      merchant1 = create(:merchant)
      item1 = create(:item, merchant: merchant1)
      
      delte "/api/v1/items/"

      
      expect(response.status).to eq(201)
      
      created_item = Item.last

      expect(Item.count).to eq(1)
      expect(created_item.name).to eq(item_params[:name])
      expect(created_item.description).to eq(item_params[:description])
      expect(created_item.unit_price).to eq(item_params[:unit_price])
      expect(created_item.merchant_id).to eq(item_params[:merchant_id])
    end
  end
end
