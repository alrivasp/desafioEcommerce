class Category < ApplicationRecord
  has_and_belongs_to_many :products
  #Cada categoria pertenece a otra, el parent es un category se cambia el nombre por inteligencia de RoR
  #Esta tiene la posibilidad de ser nula  por lo que se activa el optional y se especifica que hace referencia
  belongs_to :parent, class_name: 'Category', optional: true, foreign_key: :category_id

  #Como Pueden ser hijas tambien pueden ser padres entonces se agrega un has many con el nombre hijos children
  #Se hace la referencia al nombre del modelo y se agrega la eliminacion en cascada en la cual depende de su padre
  has_many :children, class_name: 'Category', dependent: :destroy

  #Saber todos los padres donde no tenga hijos
  scope :all_parents, -> {where(category_id: nil)}

  #traer todos los hijos
  #que hace flat map todos los objetos los estructura de la misma manera que el inicial el map solo lo hace con los 2 primeros y va haciendo su trabajao uno por uno
  #flat_map lo hace al mismo nivel si separarlo 
  def all_children
    self.children.flat_map do |child|
      child.all_children << child
    end
  end
end
