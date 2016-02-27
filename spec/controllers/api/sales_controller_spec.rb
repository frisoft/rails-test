require 'rails_helper'

RSpec.describe Api::SalesController, :type => :controller do

  describe 'POST create' do
    it 'responses with status 201 created' do
      post :create, sales_params
      expect(response).to have_http_status(:created)
    end
    it 'creates the sales' do
      post :create, sales_params
      json = json_response
      expect(json).to include 'sales'
    end
  end

end
