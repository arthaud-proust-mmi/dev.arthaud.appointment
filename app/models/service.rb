class Service < ApplicationRecord
  belongs_to :user

  has_many :meets

  validates :title, presence: { message: 'Le titre est obligatoire' }
  validates :price, presence: { message: 'Le prix est obligatoire' }
  validates :unit, presence: { message: 'L\'unité est obligatoire' }
end
