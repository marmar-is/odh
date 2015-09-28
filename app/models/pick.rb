class Pick < ActiveRecord::Base
  # Associations
  belongs_to :exposition
  belongs_to :account
end
