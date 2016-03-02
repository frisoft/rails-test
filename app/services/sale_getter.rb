class SaleGetter

  def initialize(listener = nil)
    @listener = listener
  end

  def get(id, password)
    sale = get_sale(id, password)
    @listener.sale_found(sale) if sale
  end

  private

  def get_sale(id, password)
    sale = SaleModel.find_by_id(id)
    unless sale
      @listener.sale_not_found
      return nil
    end
    unless Authorizer.new(sale).authorize?(password)
      @listener.sale_get_unhautorized
      return nil
    end
    sale
  end

end
