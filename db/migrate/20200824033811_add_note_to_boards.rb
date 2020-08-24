class AddNoteToBoards < ActiveRecord::Migration[6.0]
  def change
    add_column :boards, :note, :text
  end
end
