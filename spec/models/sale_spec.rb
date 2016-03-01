require 'rails_helper'

RSpec.describe Sale, :type => :model do

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

  describe '.create' do
    it 'save the sale using the virtual attributes date and time' do
      sale = described_class.create({date: '20140103', time: '0700', code: 'FL', value: '2.00'})
      sale.reload
      expect(sale.date).to eq '20140103'
      expect(sale.time).to eq '0700'
      expect(sale.code).to eq 'FL'
      expect(sale.value).to eq 2.00
    end
    it 'generate volatile password and a persintence encrypted_password for the new sale' do
      sale = described_class.create({date: '20140103', time: '0700', code: 'FL', value: '2.00'})
      expect(sale.password).not_to be nil
      expect(sale.encrypted_password).not_to be nil
      sale2 = described_class.find_by_id(sale.id)
      expect(sale2.password).to be nil
      expect(sale2.encrypted_password).not_to be nil
    end
  end

  describe '#password=' do
    it 'sets password virtual attribute' do
      subject.password='mypassword'
      expect(subject.password).to eq 'mypassword'
    end
    it 'sets encrypted_password attribute' do
      subject.password='mypassword'
      expect(subject.encrypted_password).not_to be nil
    end
  end

end
