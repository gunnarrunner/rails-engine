require 'rails_helper'

RSpec.describe "Items API", type: :request do

  describe 'DELETE /items' do
    it 'can create an item with no errors' do
      merchant1 = create(:merchant)
      item1 = create(:item, merchant: merchant1)
      
      item1 = Item.last
      expect(Item.count).to eq(1)

      delete "/api/v1/items/#{item1.id}"

      expect(response.status).to eq(204)
      
      expect(Item.count).to eq(0)
    end

    it 'will throw an error if it can not find an item' do
      delete "/api/v1/items/69"

      expect(response.status).to eq(404)
    end
  end
end
