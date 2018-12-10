class Store < ApplicationRecord
  resourcify
  acts_as_commentable
  acts_as_votable
  acts_as_followable
  belongs_to :user
  has_many :products
  VALID_PHONE_NUMBER = /\A0([0-9]{1,2})([0-9]{3,4})([0-9]{4})\z/

  validates :phone_number, presence: true, format: { with: VALID_PHONE_NUMBER }
end
