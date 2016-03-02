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
        expect(json['sales'].first.keys.sort).to eq ["code", "date", "id", "password", "time", "value"]
      end
    end
    context 'creating a single sale' do
      it 'creates a single sale' do
        post :create, single_sale_params
        json = json_response
        expect(json).to include 'sales'
        expect(json['sales'].length).to eq 1
        expect(json['sales'].first.keys.sort).to eq ["code", "date", "id", "password", "time", "value"]
      end
    end
  end

  describe 'GET sale' do
    let!(:sale) { sale_factory }
    context "getting an existing sale" do
      it 'returns the sale' do
        get :show, id: sale.id, password: 'strongpassword'
        json = json_response
        expect(json).to eq({"code" => "AB", "date" => "20160227", "id" => sale.id, "time" => "2012", "value" => "12.99"})
      end
    end
    context "getting a inexisting sale" do
      it 'returns status 404' do
        get :show, id: 666
        expect(response).to have_http_status(404)
      end
    end
    context "getting sale with a wrong password" do
      it 'returns status 401' do
        get :show, id: sale.id, password: 'wrongpassword'
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'DELETE sale' do
    context "deleting an existing sale" do
      let!(:sale) { sale_factory }
      it 'delete the sale' do
        delete :destroy, id: sale.id, password: 'strongpassword'
        expect(response).to have_http_status(200)
        expect(Sale.count).to eq 0
      end
    end
    context "deleting an inexisting sale" do
      it 'returns status 404' do
        delete :destroy, id: 666
        expect(response).to have_http_status(404)
      end
    end
  end

end
