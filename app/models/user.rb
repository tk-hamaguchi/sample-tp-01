class User < ApplicationRecord
  has_many :boards, dependent: :destroy
  has_many :pins, through: :boards

  validates :name, presence: true
end
