require 'rails_helper'

describe Encryptor do

  describe '#encrypt' do
    it 'encrypts a string' do
      text = 'some text'
      expect(subject.encrypt(text)).to eq Digest::SHA1.hexdigest(text)
    end
    it 'accepts nil as argument treating it as empty string' do
      expect(subject.encrypt(nil)).to eq subject.encrypt('')
    end
  end

end
