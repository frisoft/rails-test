require 'rails_helper'

describe Authorizer do

  describe '#authorize?' do
    context 'using a correct password' do
      it 'returns true' do
        encryptor = double('encryptor')
        expect(encryptor).to receive(:encrypt).with('rightpassword').and_return('encrypted-rightpassword')
        model = double(encrypted_password: 'encrypted-rightpassword')
        expect(described_class.new(model, encryptor).authorize?('rightpassword')).to be true
      end
    end
    context 'using an incorrect password' do
      it 'returns false' do
        encryptor = double('encryptor')
        expect(encryptor).to receive(:encrypt).with('wrongpassword').and_return('encrypted-wrongpassword')
        model = double(encrypted_password: 'encrypted-rightpassword')
        expect(described_class.new(model, encryptor).authorize?('wrongpassword')).to be false
      end
    end
  end

end
