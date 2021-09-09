require 'rails_helper'

RSpec.describe "Merchants Items API", type: :request do

  describe 'GET /merchants/:id/items' do
    it 'can give all the items associated with a merchant' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      item1 = create(:item, merchant: merchant1)
      item2 = create(:item, merchant: merchant1)
      item3 = create(:item, merchant: merchant1)
      item4 = create(:item, merchant: merchant1)
      item5 = create(:item, merchant: merchant2)
      item6 = create(:item, merchant: merchant2)

      get "/api/v1/merchants/#{merchant1.id}/items"
      
      expect(response.status).to eq(200)

      merchant_items = JSON.parse(response.body, symbolize_names: true)
      
      expect(merchant_items.class).to eq(Hash)
      expect(merchant_items[:data].class).to eq(Array)
      

      merchant_items[:data].each do |item|
        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)
        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)
        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)
        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:merchant_id]).to be_a(Integer)
      end
    end

    it 'can give an error code when a merchant does not exist' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      item1 = create(:item, merchant: merchant1)
      item2 = create(:item, merchant: merchant1)
      item3 = create(:item, merchant: merchant1)
      item4 = create(:item, merchant: merchant1)
      item5 = create(:item, merchant: merchant2)
      item6 = create(:item, merchant: merchant2)

      get "/api/v1/merchants/100/items"
      
      expect(response.status).to eq(404)
    end
  end
end
