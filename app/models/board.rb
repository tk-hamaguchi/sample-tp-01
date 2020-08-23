class Board < ApplicationRecord
  belongs_to :user

  has_many :pins,    dependent: :destroy
  has_many :re_pins, dependent: :destroy

  accepts_nested_attributes_for :re_pins

  validates :name, presence: true
end
