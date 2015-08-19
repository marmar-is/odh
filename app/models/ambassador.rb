class Ambassador < ActiveRecord::Base
  # Callbacks
  before_save :set_unique_token
  after_create :set_registration_token

  # Associations
  has_one :account, as: :meta, dependent: :destroy

  belongs_to :parent, class_name: :Ambassador, foreign_key: "parent_id"
  has_many :children, class_name: :Ambassador, foreign_key: "parent_id"

  # Enumerations
  enum status: [ :prospective, :registered, :active ]

  # Order
  default_scope { order('created_at DESC') }

  # Validations
  validates :email,  presence: true # validated through devise 
  validates :phone,  presence: true, numericality: { only_integer: true }
  validates :fname,  presence: true, length: { minimum: 2 }
  validates :lname,  presence: true, length: { minimum: 2 }
  validates :dob,    presence: true, timeliness: { on_or_before: lambda { Date.current }, type: :date }
  validates :street, presence: true
  validates :city,   presence: true
  validates :state,  presence: true
  validates :zip,    presence: true

  # Methods
  # Get Full Name
  def full_name
    self.fname + " " + self.lname
  end

  def initials
    self.fname.first + self.lname.first
  end

  # Overwrite phone setter to strip non-numerics
  def phone=(phone)
    write_attribute(:phone, phone.gsub(/\D/, ''))
  end

  private
    # Set & Generate Unique Token
    def set_unique_token
      return if (self.prospective? || token.present?)
      self.token = generate_unique_token
    end

    def generate_unique_token
      begin
        token = self.initials.upcase + sprintf('%03d', rand(0..999))
      end while self.class.exists?(token: token)
      return token
    end

    # Set & Generate Registration Token
    def set_registration_token
      return if !self.prospective?
      self.update(registration_token: generate_registration_token)
    end

    def generate_registration_token
      SecureRandom.uuid.gsub(/\-/,'')+SecureRandom.uuid.gsub(/\-/,'')
    end

end
