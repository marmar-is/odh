class Exposition < ActiveRecord::Base
  # Associations
  belongs_to :home, class_name: "Team"
  belongs_to :away, class_name: "Team"
  belongs_to :week
  has_many :picks

  # Scopes
  #scope :by_week, -> (week_number) { joins(:week).where("weeks.number= ?", week_number) }
end
