require 'rails_helper'

RSpec.describe "Items API", type: :request do

  describe 'GET /items/:id' do
    it 'can give specific information on a specific item' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      item1 = create(:item, merchant: merchant1)
      item2 = create(:item, merchant: merchant1)
      item3 = create(:item, merchant: merchant1)
      item4 = create(:item, merchant: merchant1)
      item5 = create(:item, merchant: merchant2)
      item6 = create(:item, merchant: merchant2)
      item7 = create(:item, merchant: merchant2)
      item8 = create(:item, merchant: merchant2)
      item9 = create(:item, merchant: merchant2)
      item10 = create(:item, merchant: merchant2)

      get "/api/v1/items/#{item10.id}"
      
      expect(response.status).to eq(200)
      
      item = JSON.parse(response.body, symbolize_names: true)

      expect(item.class).to eq(Hash)
      expect(item[:data].class).to eq(Hash)
      

      expect(item[:data][:attributes]).to have_key(:name)
      expect(item[:data][:attributes]).to have_key(:description)
      expect(item[:data][:attributes]).to have_key(:unit_price)
      expect(item[:data][:attributes]).to have_key(:merchant_id)
      expect(item[:data][:attributes][:name]).to be_a(String)
      expect(item[:data][:attributes][:name]).to eq(item10.name)
      expect(item[:data][:attributes][:description]).to be_a(String)
      expect(item[:data][:attributes][:description]).to eq(item10.description)
      expect(item[:data][:attributes][:unit_price]).to be_a(Float)
      expect(item[:data][:attributes][:unit_price]).to eq(item10.unit_price)
      expect(item[:data][:attributes][:merchant_id]).to be_a(Integer)
      expect(item[:data][:attributes][:merchant_id]).to eq(merchant2.id)

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
      item7 = create(:item, merchant: merchant2)
      item8 = create(:item, merchant: merchant2)
      item9 = create(:item, merchant: merchant2)
      item10 = create(:item, merchant: merchant2)

      get "/api/v1/items/150"
      
      expect(response.status).to eq(404)
    end
  end
end
