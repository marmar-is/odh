class Pick < ActiveRecord::Base
  # Associations
  belongs_to :exposition
  belongs_to :ambassador
end
