require 'rails_helper'

RSpec.describe Chef, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
  end
  describe "relationships" do
    it {should have_many :dishes}
  end

  before :each do
    @chef1 = Chef.create(name: "Chef1")
    @chef2 = Chef.create(name: "Chef2")
    @dish10 = @chef1.dishes.create(name: "Dish10", description: "description10")
    @dish11 = @chef1.dishes.create(name: "Dish11", description: "description11")
    @dish2 = @chef2.dishes.create(name: "Dish2", description: "description2")
    @ing1 = Ingredient.create(name: "Ingredient1", calories: 100)
    @ing2 = Ingredient.create(name: "Ingredient2", calories: 200)
    @ing3 = Ingredient.create(name: "Ingredient3", calories: 300)
    @ing4 = Ingredient.create(name: "Ingredient4", calories: 400)
    @ing5 = Ingredient.create(name: "Ingredient5", calories: 500)

    DishIngredient.create(dish_id: @dish10.id, ingredient_id: @ing1.id)
    DishIngredient.create(dish_id: @dish10.id, ingredient_id: @ing2.id)
    DishIngredient.create(dish_id: @dish10.id, ingredient_id: @ing3.id)
    DishIngredient.create(dish_id: @dish11.id, ingredient_id: @ing2.id)
    DishIngredient.create(dish_id: @dish11.id, ingredient_id: @ing3.id)
    DishIngredient.create(dish_id: @dish11.id, ingredient_id: @ing4.id)
    DishIngredient.create(dish_id: @dish2.id, ingredient_id: @ing5.id)
  end
  it "uniq_ingredients" do
    expect(@chef1.uniq_ingredients).to eq([@ing1.name, @ing2.name, @ing3.name, @ing4.name])
  end
  

end
