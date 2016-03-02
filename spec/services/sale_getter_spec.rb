require 'rails_helper'

describe SaleGetter do

  describe '#get' do
    let(:sale){sale_factory}
    context 'valid id and password' do
      it 'calls listener.show_sale' do
        listener = double('listener')
        expect(listener).to receive(:sale_found)
        described_class.new(listener).get(sale.id, 'strongpassword')
      end
    end
    context 'invalid id' do
      it 'calls listener.sale_not_found' do
        listener = double('listener')
        expect(listener).to receive(:sale_not_found)
        described_class.new(listener).get(0, 'strongpassword')
      end
    end
    context 'valid id but invalid password' do
      it 'calls listener.sale_get_unhautorized' do
        listener = double('listener')
        expect(listener).to receive(:sale_get_unhautorized)
        described_class.new(listener).get(sale.id, 'wrongpassword')
      end
    end
  end

end
