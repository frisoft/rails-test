class Api::SalesController < ApplicationController

  def create
    SaleCreator.new(self).create(params)
  end

  def show
    SaleGetter.new(self).get(params[:id], params[:password])
  end

  def destroy
    SaleDestroyer.new(self).destroy(params[:id], params[:password])
  end

  def sales_created_succesfully(sales)
    render json: {
      sales: sales.as_json(only: [:id, :date, :time, :code, :value, :password])
    }, status: 201
  end

  def sale_found(sale)
    render json: sale.as_json(only: [:id, :date, :time, :code, :value]), status: 200
  end

  def sale_not_found
    render json: {error: 'sale not found'}, status: 404
  end

  def sale_get_unhautorized
    render json: {error: 'Unauthorized'}, status: 401
  end

  def sale_destroyed(sale)
    render json: {message: 'sale deleted'}, status: 200
  end

end
