class Ambassador < ActiveRecord::Base
  # Associations
  has_one :account, as: :meta, dependent: :destroy
  
  belongs_to :ambassador, as: :parent
  has_many :ambassadors, as: :children

end
