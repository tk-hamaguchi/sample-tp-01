class BoardsController < ApplicationController
  def index
  end

  def show
  end

  def create
    @board = Board.create! board_params.merge(user: current_user)

    redirect_to root_path, notice: t('.flash.success')
  end

  def update
  end

  def destroy
  end

  private

  def board_params
    params.require(:board).permit(:name, :note, re_pins_attributes: [:pin_id])
  end
end
