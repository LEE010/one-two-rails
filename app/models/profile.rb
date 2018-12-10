class Profile < ApplicationRecord
  VALID_PHONE_NUMBER = /\A010([1-9]{1}[0-9]{3})([0-9]{4})\z/
  resourcify
  belongs_to :user, dependent: :destroy, optional: true
  validates :name, presence: true, length: { minimum: 1, maximum: 30 }
  validates :mobile, presence: true, format: { with: VALID_PHONE_NUMBER }
  # :address
  # :birth

end
