class Profile < ApplicationRecord
  VALID_PHONE_NUMBER = /\A010([1-9]{1}[0-9]{3})([0-9]{4})\z/
  mount_uploader :image, AvatarUploader
  resourcify
  belongs_to :user, dependent: :destroy, optional: true
  validates :name, presence: true, length: { minimum: 1, maximum: 30 }
  validates :mobile, presence: true, format: { with: VALID_PHONE_NUMBER }
  validate :image_size
  # :address
  # :birth
  
  private

  def image_size
    if self.image.size > 5.megabyte
      errors.add(:cover, '이미지 크기는 5mb 보다 작아야 합니다.')
    end
  end

end
