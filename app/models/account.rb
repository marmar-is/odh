class Account < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable, :confirmable, :lockable

  # Associations
  belongs_to :meta, polymorphic: true # Polymorphic association for Accounts + Ambassador/Etc.
end
