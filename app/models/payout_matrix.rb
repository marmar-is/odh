class PayoutMatrix < ActiveRecord::Base
  # Validations
  validates :generation, presence: true, numericality: { greater_than_or_equal_to: 1 }, uniqueness: true
  validates :amount,     presence: true, numericality: { greater_than_or_equal_to: 0 }
end
