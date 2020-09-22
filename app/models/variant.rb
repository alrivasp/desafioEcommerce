class Variant < ApplicationRecord
  belongs_to :product
  belongs_to :color
  belongs_to :size
  #scope indica que es una llave compuesta uniendo el color id y la talla id
  validates :product_id, uniqueness: { scope: [:color_id, :size_id] }
end
