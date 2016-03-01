class Api::SalesController < ApplicationController

  before_action :get_sale,  only: [:show, :destroy]

  def create
    sales = [params[:sales]].flatten.map do |sale|
      sale_model = SaleModel.new
      sale_model.attributes = secure_sale_params(sale)
      new_sale = WithPassword.new(sale_model)
      new_sale.save!
      new_sale
    end
    render json: {
      sales: sales.as_json(only: [:id, :date, :time, :code, :value, :password])
    }, status: 201
  end

  def show
    render json: @sale.as_json(only: [:id, :date, :time, :code, :value]), status: 200
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
    @sale = SaleModel.find_by_id(params[:id])
    unless @sale
      render json: {error: 'sale not found'}, status: 404
      return false
    end
    unless Authorizer.new(@sale).authorize?(params[:password])
      render json: {error: 'Unauthorized'}, status: 401
      return false
    end
  end

end
