require 'rails_helper'

describe SaleDestroyer do

  describe '#destroy' do
    let(:sale){sale_factory}
    context 'valid id and password' do
      it 'calls listener.sale_destroyed' do
        listener = double('listener')
        expect(listener).to receive(:sale_destroyed)
        described_class.new(listener).destroy(sale.id, 'strongpassword')
        expect(Sale.count).to eq 0
      end
    end
    context 'invalid id' do
      it 'calls listener.sale_not_found' do
        listener = double('listener')
        expect(listener).to receive(:sale_not_found)
        described_class.new(listener).destroy(0, 'strongpassword')
      end
    end
    context 'valid id but invalid password' do
      it 'calls listener.sale_get_unhautorized' do
        listener = double('listener')
        expect(listener).to receive(:sale_get_unhautorized)
        described_class.new(listener).destroy(sale.id, 'wrongpassword')
      end
    end
  end

end
