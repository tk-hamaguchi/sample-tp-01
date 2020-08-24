class BoardsController < ApplicationController
  def index
    @boards = current_user.boards
  end

  def show
    @board = current_user.boards.includes(:pins, :re_pins).find(params[:id])
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
