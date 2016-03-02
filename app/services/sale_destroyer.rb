class SaleDestroyer < SaleGetter

  def destroy(id, password)
    sale = get_sale(id, password)
    if sale
      sale.destroy
      @listener.sale_destroyed(sale)
    end
  end

end
