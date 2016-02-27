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
      end
    end

    context 'sending a single sale' do
      it 'returns a json with a key sales with a single hash of sale attributes' do
        post '/api/sales.json', single_sale_params
        json = json_response
        expect(json).to include 'sales'
        expect(json['sales'].length).to eq 1
      end
    end

  end

end
