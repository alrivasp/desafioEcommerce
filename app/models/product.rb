class Product < ApplicationRecord
  has_and_belongs_to_many :categories

  has_many :variants
  # has_many :order_items
  # has_many :orders, through: :order_items

  def visible_on_catalog?
    

    total_stock = self.variants.map(&:stock).inject(0,&:+)
    (total_stock > 0)
  end
end
