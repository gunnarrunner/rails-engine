require 'rails_helper'

RSpec.describe "Merchants API", type: :request do

  describe 'GET /merchants' do
    it 'can give a list of 20 merchants successfully' do
      create_list(:merchant, 25)

      get '/api/v1/merchants'
      
      expect(response.status).to eq(200)
      
      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants.class).to eq(Hash)
      expect(merchants[:data].class).to eq(Array)
      
      expect(merchants[:data].count).to eq(20)

      merchants[:data].each do |merchant|
        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)
      end
    end

    it 'has no merchants and returns an array' do
      get '/api/v1/merchants'

      expect(response.status).to eq(200)

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data].class).to eq(Array)
      expect(merchants[:data].length).to eq(0)
    end

    it 'it can put it params for a page and number of merchants per page' do
      create_list(:merchant, 50)
      
      get '/api/v1/merchants?page=1&per_page=35'
      
      expect(response.status).to eq(200)
      
      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data].count).to eq(35)

      merchants[:data].each do |merchant|
        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)
      end
    end

    it 'can get data on pages greater than one' do
      create_list(:merchant, 50)
      
      get '/api/v1/merchants?page=5'
      
      expect(response.status).to eq(200)
      
      merchants = JSON.parse(response.body, symbolize_names: true)

      merchants[:data].each do |merchant|
        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)
      end
    end

    it 'can show the first page of the api when the page is 0 or a number less than 0' do
      create_list(:merchant, 50)

      get '/api/v1/merchants?page=0'
      
      expect(response.status).to eq(200)
      
      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data].count).to eq(20)

      merchants[:data].each do |merchant|
        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)
      end
    end
  end
end
