class Feature < ApplicationRecord
  has_many :game_features
  has_many :games, through: :game_features
end
