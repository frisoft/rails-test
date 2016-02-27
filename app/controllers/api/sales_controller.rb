class Api::SalesController < ApplicationController

  def create
    sales = [params[:sales]].flatten.map do |sale|
      Sale.create(secure_sale_params(sale))
    end
    render json: {
      sales: sales.as_json(only: [:id, :code, :value], methods: [:date, :time])
    }, status: 201
  end

  def show
    sale = Sale.find_by_id(params[:id])
    if sale
      render json: sale.as_json(only: [:id, :code, :value], methods: [:date, :time]), status: 201
    else
      render json: {error: 'sale not found'}, status: 404
    end
  end

  private

  def secure_sale_params(params)
    params.permit(:date, :time, :code, :value)
  end

end
