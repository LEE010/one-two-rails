class Store < ApplicationRecord
  VALID_PHONE_NUMBER = /\A0([0-9]{1,2})([0-9]{3,4})([0-9]{4})\z/
  mount_uploader :image, AvatarUploader
  resourcify
  acts_as_commentable
  acts_as_votable
  acts_as_followable
  belongs_to :user
  has_many :products
  
  validates :phone_number, presence: true, format: { with: VALID_PHONE_NUMBER }
  validate :image_size
  
  private

  def image_size
    if self.image.size > 5.megabyte
      errors.add(:cover, '이미지 크기는 5mb 보다 작아야 합니다.')
    end
  end
end
