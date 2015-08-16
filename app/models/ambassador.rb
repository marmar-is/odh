class Ambassador < ActiveRecord::Base
  # Callbacks
  before_save :create_unique_token

  # Associations
  has_one :account, as: :meta, dependent: :destroy

  belongs_to :parent, class_name: :Ambassador, foreign_key: "parent_id"
  has_many :children, class_name: :Ambassador, foreign_key: "parent_id"

  # Enumerations
  enum status: [ :prospective, :registered, :active ]

  # Tokens
  has_secure_token :registration_token

  # Methods
  # Get Full Name
  def full_name
    self.fname + " " + self.lname
  end

  def initials
    self.fname.first + self.lname.first
  end

  def create_unique_token
    if self.registered?
      begin
        self.token = self.initials + sprintf('%03d', rand(0..999))
      end while self.class.exists?(token: token)
    end
  end

  # Overwrite phone setter to strip non-numerics
  def phone=(phone)
    write_attribute(:phone, phone.gsub(/\D/, ''))
  end

end
