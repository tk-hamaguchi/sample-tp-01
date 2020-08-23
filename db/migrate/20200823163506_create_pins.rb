class CreatePins < ActiveRecord::Migration[6.0]
  def change
    create_table :pins do |t|
      t.string :title
      t.references :board, null: false, foreign_key: true
      t.text :note
      t.string :link_to

      t.timestamps
    end
  end
end
