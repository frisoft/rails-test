require 'rails_helper'

RSpec.describe Api::SalesController, :type => :controller do

  describe 'POST create' do
    it 'response with status 201 created' do
      post :create, {sales: sales_params}
      expect(response).to have_http_status(:created)
    end
  end

end
