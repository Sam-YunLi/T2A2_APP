class Game < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :platform
  has_many :game_features, dependent: :destroy
  has_many :features, through: :game_features

  # conditions  brand new, gently used, used and still_useable
  enum condition: {brand_new: 1, gently_used: 2, used: 3, still_useable: 4}
  has_one_attached :picture
end
