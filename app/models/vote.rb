class Vote < ApplicationRecord
  belongs_to :character
  validates :value, presence: true
  enum value: [:fuck, :marry, :kill]
end
