class Meet < ApplicationRecord
  belongs_to :user
  belongs_to :service

  validates :planned_at, presence: { message: 'La date est obligatoire %{value}' }
end
