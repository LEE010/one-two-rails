class Product < ApplicationRecord
  mount_uploader :image, ProductImgUploader
  resourcify
  belongs_to :store
  has_many :options
  accepts_nested_attributes_for :options, allow_destroy: true

  validates :name, presence: true
  validates :info, length: { minimum: 10 }
  validate :image_size

  private

  def image_size
    if self.image.size > 5.megabyte
      errors.add(:cover, '이미지 크기는 5mb 보다 작아야 합니다.')
    end
  end
end
