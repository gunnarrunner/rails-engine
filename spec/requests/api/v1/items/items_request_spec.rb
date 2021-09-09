require 'rails_helper'

RSpec.describe "Items API", type: :request do

  describe 'GET /items' do
    it 'can give a list of 20 items successfully' do
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
      item11 = create(:item, merchant: merchant2)
      item12 = create(:item, merchant: merchant1)
      item13 = create(:item, merchant: merchant1)
      item14 = create(:item, merchant: merchant1)
      item15 = create(:item, merchant: merchant1)
      item16 = create(:item, merchant: merchant1)
      item17 = create(:item, merchant: merchant1)
      item18 = create(:item, merchant: merchant1)
      item19 = create(:item, merchant: merchant1)
      item20 = create(:item, merchant: merchant1)
      item21 = create(:item, merchant: merchant1)

      get '/api/v1/items'
      
      expect(response.status).to eq(200)
      
      items = JSON.parse(response.body, symbolize_names: true)

      expect(items.class).to eq(Hash)
      expect(items[:data].class).to eq(Array)
      
      expect(items[:data].count).to eq(20)

      items[:data].each do |item|
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

    it 'has no items and returns an array' do
      get '/api/v1/items'

      expect(response.status).to eq(200)

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data].class).to eq(Array)
      expect(merchants[:data].length).to eq(0)
    end

    it 'can put it params for a page and number of items per page' do
      merchant1 = create(:merchant)
        50.times do
          create(:item, merchant: merchant1)
        end
      get '/api/v1/items?page=1&per_page=35'
      
      expect(response.status).to eq(200)
      
      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(35)

      items[:data].each do |item|
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

    it 'can get data on pages greater than one' do
      merchant1 = create(:merchant)
        50.times do
          create(:item, merchant: merchant1)
        end
      
      get '/api/v1/items?page=5'
      
      expect(response.status).to eq(200)
      
      items = JSON.parse(response.body, symbolize_names: true)

      items[:data].each do |item|
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

    it 'can show the first page of the api when the page is 0 or a number less than 0' do
      merchant1 = create(:merchant)
        50.times do
          create(:item, merchant: merchant1)
        end

      get '/api/v1/items?page=0'
      
      expect(response.status).to eq(200)
      
      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(20)

      items[:data].each do |item|
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
  end
end
