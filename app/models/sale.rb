require 'securerandom'

class Sale < ActiveRecord::Base

  before_create :set_password

  @password = nil

  def date=(d)
    self.dt = Date.parse(d)
  end

  def date
    dt.strftime('%Y%m%d')
  end

  def time=(t)
    hh = t[0,2].to_i
    mm = t[2,2].to_i
    self.tm = Time.new(2000, 1, 1, hh, mm)
  end

  def time
    tm.strftime('%H%M')
  end

  def password=(password)
    @password = password
    self.encrypted_password = password_digest(password)
  end

  def password
    @password
  end

  def authorized?(password)
    !password.blank? && encrypted_password == password_digest(password)
  end

  private

  def set_password
    self.password ||= SecureRandom.hex
  end

  def password_digest(password)
    Digest::SHA1.hexdigest(password)
  end

end
