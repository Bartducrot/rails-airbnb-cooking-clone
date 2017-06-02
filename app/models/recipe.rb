class Recipe < ApplicationRecord
  belongs_to :user
  has_many :transactions
  validates :photo, presence: true
  mount_uploader :photo, PhotoUploader

  def self.search(search)
    where("title ILIKE ? OR description ILIKE ? OR instructions ILIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
  end

  def avg_rating
    sum = 0
    nb = 0
    self.transactions.each do |transaction|
      if transaction.rating
        sum += transaction.rating
        nb += 1
      end
    end

    if nb != 0
      return (sum / nb).to_i
    else
      return 0
    end
  end
end
