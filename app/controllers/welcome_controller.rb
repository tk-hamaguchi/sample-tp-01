class WelcomeController < ApplicationController
  def index
    @pins = Pin.includes(board: [:user]).where.not(boards: { user: current_user })
    @new_board = Board.new
    @new_board.re_pins.build
    @my_boards = Board.where(user: current_user)
  end
end
