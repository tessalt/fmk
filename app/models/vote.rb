class Vote < ApplicationRecord
  belongs_to :character
  enum value: [:fuck, :marry, :kill]
end
