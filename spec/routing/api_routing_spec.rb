require 'rails_helper'

describe 'api routes', :type => :routing do
  describe 'create sales' do
    it do
      expect(post: '/api/sales.json').to route_to(
        controller: 'api/sales',
        action: 'create',
        format: 'json'
      )
    end
  end
end
