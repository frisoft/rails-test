require 'rails_helper'

describe 'Sales API', :type => :request do

  describe 'create sales' do

    context 'sending a collection of params' do
      before do
        post '/api/sales.json', sales_params
      end
      it 'returns status 201' do
        expect(response).to have_http_status(:created)
      end
      it 'returns a json with the sale details and the new id to use to fetch the sales later' do
        json = json_response
        expect(json).to include 'sales'
        expect(json['sales'].first.keys.sort).to eq ["code", "date", "id", "time", "value"]
      end
    end

    context 'sending a single sale' do
      it 'returns a json with a key sales with a single hash of sale attributes' do
        post '/api/sales.json', single_sale_params
        json = json_response
        expect(json).to include 'sales'
        expect(json['sales'].length).to eq 1
        expect(json['sales'].first.keys.sort).to eq ["code", "date", "id", "time", "value"]
      end
    end

  end

  describe 'get sale by id' do
    context 'getting an existing sale' do
      let!(:sale) { sale_factory }

      it 'returns the single sale as json' do
        get "/api/sales/#{sale.id}.json"
        json = json_response
        expect(json).to eq({"code" => "AB", "date" => "20160227", "id" => sale.id, "time" => "2012", "value" => "12.99"})
      end
    end
    context 'getting a non existing sale' do
      it 'returns srarys 404: not found' do
        get "/api/sales/666.json"
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'delete sale by id' do
    let!(:sale) { sale_factory }

    context 'deleting an existing sale' do
      it 'delete successfully the sale' do
        delete "/api/sales/#{sale.id}.json"
        expect(response).to have_http_status(:success)
      end
    end
    context 'deleting a non existing sale' do
      it 'returns srarys 404: not found' do
        delete "/api/sales/666.json"
        expect(response).to have_http_status(404)
      end
    end
  end

end
