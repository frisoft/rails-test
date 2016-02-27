class Api::SalesController < ApplicationController

  before_action :get_sale,  only: [:show, :destroy]

  def create
    sales = [params[:sales]].flatten.map do |sale|
      Sale.create(secure_sale_params(sale))
    end
    render json: {
      sales: sales.as_json(only: [:id, :code, :value], methods: [:date, :time, :password])
    }, status: 201
  end

  def show
    render json: @sale.as_json(only: [:id, :code, :value], methods: [:date, :time]), status: 200
  end

  def destroy
    if @sale.destroy
      render json: {message: 'sale deleted'}, status: 200
    end
  end

  private

  def secure_sale_params(params)
    params.permit(:date, :time, :code, :value)
  end

  def get_sale
    @sale = Sale.find_by_id(params[:id])
    unless @sale
      render json: {error: 'sale not found'}, status: 404
      return false
    end
  end

end
