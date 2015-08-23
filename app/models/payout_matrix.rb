class PayoutMatrix < ActiveRecord::Base
  # Order
  default_scope { order('generation ASC') }

  # Validations
  validates :generation, presence: true, numericality: { greater_than_or_equal_to: 1 }, uniqueness: true
  validates :amount,     presence: true, numericality: { greater_than_or_equal_to: 0 }
end
