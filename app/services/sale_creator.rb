class SaleCreator

  def initialize(listener = nil, model_class = SaleModel)
    @listener = listener
    @model_class = model_class
  end

  def create(params)
    sales = [params[:sales]].flatten.map do |sale|
      sale_model = @model_class.new
      sale_model.attributes = secure_sale_params(sale)
      new_sale = WithPassword.new(sale_model)
      new_sale.save!
      new_sale
    end
    @listener.sales_created_succesfully(sales) if @listener
  end

  def secure_sale_params(params)
    begin
      params.permit(:date, :time, :code, :value)
    rescue
      params
    end
  end

end
