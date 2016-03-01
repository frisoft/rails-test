class Encryptor

  def encrypt(text)
    Digest::SHA1.hexdigest(text.to_s)
  end

end
