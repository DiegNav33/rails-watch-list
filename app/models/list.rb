class List < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :movies, through: :bookmarks, dependent: :destroy
  has_many :reviews, dependent: :destroy
  belongs_to :user
  has_one_attached :image
  validates :name, presence: true, uniqueness: true
  validate :image_type
  validate :image_size

  private

  def image_type
    if image.attached? && !image.content_type.in?(%w(image/jpeg image/png image/jpg))
      errors.add(:image, 'Must be a JPEG or PNG')
    end
  end

  def image_size
    if image.attached? && image.byte_size > 5.megabytes
      errors.add(:image, 'Size should be less than 5MB')
    end
  end
end
