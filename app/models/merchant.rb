class Merchant < ApplicationRecord
  validates :name, presence: true
  
  has_many :items
  has_many :invoices
  # has_many :, through: :
end