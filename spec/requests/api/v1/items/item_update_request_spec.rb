require 'rails_helper'

RSpec.describe "Items API", type: :request do

  describe 'PATCH /items' do
    it 'can create an item with no errors' do
      merchant1 = create(:merchant)
      id = create(:item, merchant: merchant1).id
      previous_name = Item.last.name
      item_params = { name: "Caroline" }
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate(item_params)
      item = Item.find_by(id: id)

      expect(response.status).to eq(200)
      expect(item.name).to_not eq(previous_name)
      expect(item.name).to eq("Caroline")
    end

    it 'errors out if a item can not be found' do
      merchant1 = create(:merchant)
      id = create(:item, merchant: merchant1).id
      previous_name = Item.last.name
      item_params = { name: "Caroline" }
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/items/69", headers: headers, params: JSON.generate(item_params)

      expect(response.status).to eq(404)
    end

    it 'errors out if when updating an item you do not provide a name' do
      merchant1 = create(:merchant)
      id = create(:item, merchant: merchant1).id
      previous_name = Item.last.name
      item_params = { name: "" }
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate(item_params)
      item = Item.find_by(id: id)

      expect(response.status).to eq(404)
    end
  end
end
