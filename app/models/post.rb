class Post < ApplicationRecord
  mount_uploader :image, PostUploader
  acts_as_commentable
  acts_as_votable
  belongs_to :user
  
  validates :content, presence: true
  validates :content, length: { minimum: 2 }
  validate :image_size

  private

  def image_size
    if self.image.size > 5.megabyte
      errors.add(:cover, '이미지 크기는 5mb 보다 작아야 합니다.')
    end
  end
  
end
