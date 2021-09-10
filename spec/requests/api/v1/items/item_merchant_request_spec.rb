require 'rails_helper'

RSpec.describe "Merchants Items API", type: :request do

  describe 'GET /merchants/:id/items' do
    it 'can give all the items associated with a merchant' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      item1 = create(:item, merchant: merchant1)
      item2 = create(:item, merchant: merchant2)

      get "/api/v1/items/#{item1.id}/merchant"
      
      expect(response.status).to eq(200)

      item_merchant = JSON.parse(response.body, symbolize_names: true)

      expect(item_merchant.class).to eq(Hash)
      expect(item_merchant[:data].class).to eq(Hash)
      expect(item_merchant[:data][:attributes].class).to eq(Hash)
      expect(item_merchant[:data][:attributes][:name]).to be_a(String)
    end

    it 'can give an error code when a merchant does not exist' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      item1 = create(:item, merchant: merchant1)
      item2 = create(:item, merchant: merchant2)

      get "/api/v1/items/100/merchant"
      
      expect(response.status).to eq(404)
    end
  end
end
