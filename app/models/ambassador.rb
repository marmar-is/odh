class Ambassador < ActiveRecord::Base
  # Callbacks
  before_create :set_unique_token

  # Associations
  has_one :account, as: :meta, dependent: :destroy

  belongs_to :ambassador, as: :parent
  has_many :ambassadors, as: :children

  private
  def create_unique_identifier
    begin
      self.token = self.initials + rand(0..999)
    end while self.class.exists?(token: => token)
  end

end
