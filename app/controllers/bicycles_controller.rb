class BicyclesController < ApplicationController

  def index
    @bicycles = Bicycle.all
    @bicycles = @bicycles.where(model: params[:model]) unless params[:model].blank?
    @bicycles = @bicycles.where(style: params[:style]) unless params[:style].blank?
    @bicycles = @bicycles.where(brand: params[:brand]) unless params[:brand].blank?
    @bicycles = @bicycles.where(speeds: params[:speeds]) unless params[:speeds].blank?
  end

end
