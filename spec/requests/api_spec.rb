require 'rails_helper'

describe 'Sales API', :type => :request do

  describe 'create sales' do

    context 'receiving a collection of params' do
      it 'return status 201' do
        post '/api/sales.json', {sales: sales_params}
        expect(response).to have_http_status(:created)
      end
    end

  end

end
