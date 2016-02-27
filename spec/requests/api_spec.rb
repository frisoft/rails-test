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
        expect(json['sales'].first.keys.sort).to eq ["code", "date", "id", "password", "time", "value"]
      end
    end

    context 'sending a single sale' do
      it 'returns a json with a key sales with a single hash of sale attributes' do
        post '/api/sales.json', single_sale_params
        json = json_response
        expect(json).to include 'sales'
        expect(json['sales'].length).to eq 1
        expect(json['sales'].first.keys.sort).to eq ["code", "date", "id", "password", "time", "value"]
        sale = json['sales'].first
        expect(sale['id']).not_to be nil
        expect(sale['code']).to eq 'FL'
        expect(sale['value']).to eq "2.0"
        expect(sale['date']).to eq "20140103"
        expect(sale['time']).to eq "0700"
        expect(sale['password']).not_to be nil
      end
    end

  end

  describe 'get sale by id' do
    context 'getting an existing sale' do
      let!(:sale) { sale_factory }

      context 'using a correct password' do
        it 'returns the single sale as json' do
          get "/api/sales/#{sale.id}.json", password: 'strongpassword'
          json = json_response
          expect(response).to have_http_status(200)
          expect(json).to eq({"code" => "AB", "date" => "20160227", "id" => sale.id, "time" => "2012", "value" => "12.99"})
        end
      end
      context 'using an incorrect password' do
        it 'returns status 401: Unauthorized' do
          get "/api/sales/#{sale.id}.json", password: 'wrongpassword'
          expect(response).to have_http_status(401)
        end
      end
    end
    context 'getting a non existing sale' do
      it 'returns status 404: not found' do
        get "/api/sales/666.json"
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'delete sale by id' do
    context 'deleting an existing sale' do
      let!(:sale) { sale_factory }
      context 'using a correct password' do
        it 'delete successfully the sale' do
          delete "/api/sales/#{sale.id}.json", password: 'strongpassword'
          expect(response).to have_http_status(200)
        end
      end
      context 'using an incorrect password' do
        it 'returns status 401: Unauthorized' do
          delete "/api/sales/#{sale.id}.json", password: 'wrongpassword'
          expect(response).to have_http_status(401)
        end
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
