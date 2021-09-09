require 'rails_helper'

RSpec.describe "Merchants API", type: :request do

  describe 'GET /merchants/:id' do
    it 'can give specific information on a specific merchant' do
      create_list(:merchant, 25)

      get "/api/v1/merchants/#{Merchant.last.id}"
      
      expect(response.status).to eq(200)
      
      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant.class).to eq(Hash)
      expect(merchant[:data].class).to eq(Hash)
      

      expect(merchant[:data][:attributes]).to have_key(:name)
      expect(merchant[:data][:attributes][:name]).to be_a(String)
      expect(merchant[:data][:attributes][:name]).to eq(Merchant.last.name)
    end

    it 'can give an error code when a merchant does not exist' do
      create_list(:merchant, 25)

      get "/api/v1/merchants/200"
      
      expect(response.status).to eq(404)
    end
  end
end
