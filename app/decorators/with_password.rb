require 'securerandom'

class WithPassword < SimpleDelegator

  #include ActiveModel::Serialization

  attr_reader :password

  def initialize(obj, encryptor = Encryptor.new)
    @encryptor = encryptor
    super(obj)
    set_password
  end

  def password=(password)
    @password = password
    self.encrypted_password = @encryptor.encrypt(password)
  end

  def as_json(options = nil)
    super.merge({'password' => password})
  end

  private

  def set_password
    self.password ||= SecureRandom.hex
  end

end
