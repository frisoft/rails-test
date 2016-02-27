require 'rails_helper'

RSpec.describe Api::SalesController, :type => :controller do

  describe 'POST create' do
    context 'creating a collection of sales' do
      it 'responses with status 201 created' do
        post :create, sales_params
        expect(response).to have_http_status(:created)
      end
      it 'creates the sales' do
        post :create, sales_params
        json = json_response
        expect(json).to include 'sales'
        expect(json['sales'].first.keys.sort).to eq ["code", "date", "id", "time", "value"]
      end
    end
    context 'creating a single sale' do
      it 'creates a single sale' do
        post :create, single_sale_params
        json = json_response
        expect(json).to include 'sales'
        expect(json['sales'].length).to eq 1
        expect(json['sales'].first.keys.sort).to eq ["code", "date", "id", "time", "value"]
      end
    end
  end

end
