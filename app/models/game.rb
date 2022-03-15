class Game < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :platform
  has_many :game_features, dependent: :destroy
  has_many :features, through: :game_features

  # conditions  brand new, gently used, used and still_useable
  enum condition: {brand_new: 1, gently_used: 2, used: 3, still_useable: 4}
  has_one_attached :picture

  # valadations
  validates :name, :description, :price, :condition, presence: true
  validates :name, length: {minimum: 3}

  # sanitise data with lifecycle hooks
  before_save :remove_whitespace
  before_save :remove_covid
  before_validation :convert_price_to_cents, if: :price_changed?

  private

  def remove_whitespace 
    self.name = self.name.strip
    self.description = self.description.strip
  end
  
  def remove_covid 
    self.name = self.name.gsub(/covid/i, "pfizer")
    self.description = self.name.gsub(/covid/i, "pfizer")
  end
  
  def convert_price_to_cents 
    self.price = (self.attributes_before_type_cast["price"].to_f * 100).round
  end 

end
