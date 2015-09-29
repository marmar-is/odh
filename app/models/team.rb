class Team < ActiveRecord::Base
  # Associations
  has_many :home_expositions, class_name: "Exposition", foreign_key: 'home_id'
  has_many :away_expositions, class_name: "Exposition", foreign_key: 'away_id'

  # Methods
  def expositions
    (home_expositions + away_expositions)
  end
end
