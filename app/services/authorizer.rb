class Authorizer

  def initialize(model, encryptor=Encryptor.new, encrypted_password_attribute=:encrypted_password)
    @model = model
    @encryptor = encryptor
    @encrypted_password_attribute = encrypted_password_attribute
  end

  def authorize?(password)
    @encryptor.encrypt(password) == @model.send(@encrypted_password_attribute)
  end

end
