class Sale < ActiveRecord::Base

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

end
