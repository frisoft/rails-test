require 'rails_helper'

class MockModel
  attr_accessor :attributes, :dt, :tm
  def initialize(attributes={})
    self.attributes = attributes
  end
end

describe SaleModel do

  describe '.new' do

    it 'returns an instance with all the methods of the model given as second agument' do
      sale = described_class.new({}, MockModel)
      expect(sale.attributes).to eq({})
    end

    it 'receives the attributes as first argument' do
      sale = described_class.new({attr1: 'NEW VALUE'}, MockModel)
      expect(sale.attributes).to eq(attr1: 'NEW VALUE')
    end

  end

  describe '#date=' do
    it 'saves a given date in the format "YYYYMMDD" into dt' do
      subject.date='20160227'
      expect(subject.dt).to eq Date.parse('20160227')
    end
  end

  describe '#date' do
    it 'returns the value of the attribute dt in the format "YYYYMMDD"' do
      subject.dt = Date.parse('20160227')
      expect(subject.date).to eq '20160227'
    end
  end

  describe '#time=' do
    it 'saves a given time in the format "HHMM" into tm' do
      subject.time='1629'
      expect(subject.tm.hour).to eq 16
      expect(subject.tm.min).to eq 29
    end
  end

  describe '#time' do
    it 'returns the value of the attribute dt in the format "HHMM"' do
      subject.tm = Time.new(1999,1,1,16,29)
      expect(subject.time).to eq '1629'
    end
  end

  describe '#as_json' do
    it 'returns an hash that includes date and time' do
      json = described_class.new({date: '20160227', time: '1629'}).as_json
      expect(json['date']).to eq '20160227'
      expect(json['time']).to eq '1629'
    end
  end

  describe ".find_by_id" do
    it 'finds the sale by id and create its SaleModel' do
      sale = Sale.create!
      sale_model = described_class.find_by_id(sale.id)
      expect(sale_model.id).to eq sale.id
    end
    it 'returns nil if no sale is present' do
      sale_model = described_class.find_by_id(111)
      expect(sale_model).to be nil
    end
  end

  describe '.save!' do
    it 'save the sale using the virtual attributes date and time' do
      sale = described_class.new({date: '20140103', time: '0700', code: 'FL', value: '2.00'})
      sale.save!
      sale.reload
      expect(sale.date).to eq '20140103'
      expect(sale.time).to eq '0700'
      expect(sale.code).to eq 'FL'
      expect(sale.value).to eq 2.00
    end
  end

end
