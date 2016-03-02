require 'rails_helper'

describe SaleCreator do

  describe '#create' do
    let(:params){ {sales: {date: '20170216', time: '0719', code: 'AB', value: '12.99'}} }
    it 'creates the sales given the attributes' do
      described_class.new.create(params)
      expect(Sale.count).to eq 1
    end
    it 'calls listener.sales_created_succesfully' do
      listener = double('listener')
      expect(listener).to receive(:sales_created_succesfully)
      described_class.new(listener).create(params)
    end
  end

end
