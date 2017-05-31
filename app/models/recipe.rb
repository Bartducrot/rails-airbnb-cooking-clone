class Recipe < ApplicationRecord
  belongs_to :user
  has_many :transactions
  validates :photo, presence: true
  mount_uploader :photo, PhotoUploader

  def self.search(search)
    where("title ILIKE ? OR description ILIKE ? OR instructions ILIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
  end

end
