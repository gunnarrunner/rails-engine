require 'rails_helper'

RSpec.describe "Items API", type: :request do

  describe 'POST /items' do
    it 'can create an item with no errors' do
      merchant1 = create(:merchant)

      item_params = ({
                      name: "Haku",
                      description: "Hello Rails engine",
                      unit_price: 12.99,
                      merchant_id: merchant1.id
                    })

      headers = {"CONTENT_TYPE" => "application/json"}
      
      post "/api/v1/items/",  headers: headers, params: JSON.generate(item_params)

      
      expect(response.status).to eq(201)
      
      created_item = Item.last

      expect(Item.count).to eq(1)
      expect(created_item.name).to eq(item_params[:name])
      expect(created_item.description).to eq(item_params[:description])
      expect(created_item.unit_price).to eq(item_params[:unit_price])
      expect(created_item.merchant_id).to eq(item_params[:merchant_id])
    end

    it 'can not create an item because of not filling out a params' do
      merchant1 = create(:merchant)

      item_params = ({
                      name: "Haku",
                      description: "",
                      unit_price: 12.99,
                      merchant_id: merchant1.id
                    })

      headers = {"CONTENT_TYPE" => "application/json"}
      
      post "/api/v1/items/",  headers: headers, params: JSON.generate(item_params)

      
      expect(response.status).to eq(404)
      expect(Item.count).to eq(0)
    end

    xit 'sends a 404 error when the person sends the unit price as a string' do
      merchant1 = create(:merchant)

      item_params = ({
                      name: "Haku",
                      description: "Welcome to rails",
                      unit_price: "12.99",
                      merchant_id: merchant1.id
                    })

      headers = {"CONTENT_TYPE" => "application/json"}
      
      post "/api/v1/items/",  headers: headers, params: JSON.generate(item_params)

      
      expect(response.status).to eq(404)
      expect(Item.count).to eq(0)
    end

    it 'can not create an item because of a attribute is missing' do
      merchant1 = create(:merchant)

      item_params = ({
                      name: "Haku",
                      unit_price: 12.99,
                      merchant_id: merchant1.id
                    })

      headers = {"CONTENT_TYPE" => "application/json"}
      
      post "/api/v1/items/",  headers: headers, params: JSON.generate(item_params)

      
      expect(response.status).to eq(404)
      expect(Item.count).to eq(0)
    end

    it 'can make an extra attribute and still produce an item' do
      merchant1 = create(:merchant)

      item_params = ({
                      name: "Haku",
                      description: "Welcome to rails",
                      unit_price: 12.99,
                      name_description: "explains the name",
                      merchant_id: merchant1.id
                    })

      headers = {"CONTENT_TYPE" => "application/json"}
      
      post "/api/v1/items/",  headers: headers, params: JSON.generate(item_params)

      expect(response.status).to eq(201)
      expect(Item.count).to eq(1)
    end
  end
end
