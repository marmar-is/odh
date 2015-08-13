class Ambassador < ActiveRecord::Base

  # Associations
  has_one :account, as: :meta, dependent: :destroy
end
