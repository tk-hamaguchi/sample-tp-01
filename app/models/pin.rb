class Pin < ApplicationRecord
  belongs_to :board

  has_one_attached :image

  validates :title, presence: true
end
