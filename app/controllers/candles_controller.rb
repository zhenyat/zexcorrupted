################################################################################
#  Updates the original file:
#     railties-5.0.0.beta1.1/lib/rails/generators/rails/scaffold_controller/templates/controller.rb
#
#  28.01.2016 ZT Localization added
################################################################################
class CandlesController < ApplicationController
  before_action :set_candle, only: [:show, :edit, :update, :destroy]

  def index
    @candles = Candle.all
  end

  def show
  end

  def new
    @candle = Candle.new
    @candlesticks = Candlestick.active
    @candleables = Candleable.active
  end

  def edit
  end

  def create
    @candle = Candle.new(candle_params)

    if @candle.save
      redirect_to @candle, notice: t('messages.created', model: Candle.class.model_name.human)
    else
      render :new
    end
  end

  def update
    if @candle.update(candle_params)
      redirect_to @candle, notice: t('messages.updated', model: Candle.class.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @candle.destroy
    redirect_to candles_url, notice: t('messages.deleted', model: Candle.class.model_name.human)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_candle
      @candle = Candle.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def candle_params
      params.require(:candle).permit(:candlestick_id, :candleable_id, :candleable_type, :start_stamp, :open, :high, :low, :close, :volume)
    end
end
