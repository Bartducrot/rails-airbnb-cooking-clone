class Recipe < ApplicationRecord
  belongs_to :user
  has_many :transactions
  validates :photo, presence: true
  mount_uploader :photo, PhotoUploader
end
