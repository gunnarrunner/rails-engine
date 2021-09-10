class InvoiceItem < ApplicationRecord
  validates :quantity, presence: true
  validates :unit_price, presence: true, numericality: true

  belongs_to :invoice
  belongs_to :item
  # has_many :
  # has_many :, through: :
end