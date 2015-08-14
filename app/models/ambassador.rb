class Ambassador < ActiveRecord::Base
  # Callbacks
  before_create :create_unique_token

  # Associations
  has_one :account, as: :meta, dependent: :destroy

  belongs_to :parent, class_name: :Ambassador, foreign_key: "parent_id"
  has_many :children, class_name: :Ambassador, foreign_key: "parent_id"

  # Enumerations
  enum role: [:prospective, :registered, :active]

  # Tokens
  has_secure_token :registration_token  

  private
  def create_unique_token
    if self.account
      begin
        self.token = self.account.initials + sprintf('%03d', rand(0..999))
      end while self.class.exists?(token: token)
    end
  end

end
