class Customer < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true

  # belongs_to :
  has_many :invoices
  # has_many :, through: :
end