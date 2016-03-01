class SaleModel < SimpleDelegator

  def initialize(attributes={}, obj_class = Sale)
    @obj_class = obj_class
    super(@obj_class.new)
    self.attributes = attributes
  end

  def attributes=(attributes)
    self.date = attributes.delete(:date)
    self.time = attributes.delete(:time)
    super(attributes)
  end

  def date=(d)
    self.dt = d.nil? ? nil : Date.parse(d.to_s)
  end

  def date
    dt.strftime('%Y%m%d')
  end

  def time=(t)
    if t.nil?
      self.tm = nil
    else
      hh = t[0,2].to_i
      mm = t[2,2].to_i
      self.tm = Time.new(2000, 1, 1, hh, mm)
    end
  end

  def time
    tm.strftime('%H%M')
  end

  def as_json(options = nil)
    super(options).merge({'date' => date, 'time' => time})
  end

  def self.find_by_id(id)
    sale_model = new
    obj = sale_model.obj_class.find_by_id(id)
    return nil unless obj
    sale_model.__setobj__(obj)
    sale_model
  end

  def obj_class
    @obj_class
  end

end
