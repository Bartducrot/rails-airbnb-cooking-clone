class Recipe < ApplicationRecord
  belongs_to :user
  has_many :transactions
  mount_uploader :photo, PhotoUploader
end
