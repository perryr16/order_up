class Chef <ApplicationRecord
  validates_presence_of :name
  has_many :dishes

  def uniq_ingredients
    dishes.joins(:ingredients).select('ingredients.name').distinct.pluck('ingredients.name')
  end
  

end
