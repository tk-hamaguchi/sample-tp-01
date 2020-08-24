class PinsController < ApplicationController
  def new
    @pin = Pin.new
  end

  def create
    @pin = Pin.new(pin_params)
    @pin.save!
    redirect_to @pin, notice: t('.flash.success')
  rescue ActiveRecord::RecordInvalid
    render :new
  end

  def show
    @pin = Pin.find(params[:id])
  end

  private

  def pin_params
    params.require(:pin).permit(:board_id, :image, :title, :note, :link_to)
  end
end
