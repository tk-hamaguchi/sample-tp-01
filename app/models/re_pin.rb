class RePin < ApplicationRecord
  belongs_to :pin
  belongs_to :board
end
