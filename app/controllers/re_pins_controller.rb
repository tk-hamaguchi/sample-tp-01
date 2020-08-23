class RePinsController < ApplicationController
  def create
    RePin.create!(re_pin_params)

    redirect_to root_path, notice: t('.flash.success')
  end

  private

  def re_pin_params
    params.require(:re_pin).permit(:pin_id, :board_id)
  end
end
