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
    @dish100 = @chef1.dishes.create(name: "Dish100", description: "description100")
    @dish110 = @chef1.dishes.create(name: "Dish110", description: "description110")
    @dish111 = @chef1.dishes.create(name: "Dish111", description: "description111")
    @dish2 = @chef2.dishes.create(name: "Dish2", description: "description2")
    @ing1 = Ingredient.create(name: "Ingredient1", calories: 100)
    @ing2 = Ingredient.create(name: "Ingredient2", calories: 200)
    @ing3 = Ingredient.create(name: "Ingredient3", calories: 300)
    @ing4 = Ingredient.create(name: "Ingredient4", calories: 400)
    @ing5 = Ingredient.create(name: "Ingredient5", calories: 500)

    DishIngredient.create(dish_id: @dish100.id, ingredient_id: @ing1.id)
    DishIngredient.create(dish_id: @dish100.id, ingredient_id: @ing2.id)
    DishIngredient.create(dish_id: @dish110.id, ingredient_id: @ing2.id)
    DishIngredient.create(dish_id: @dish100.id, ingredient_id: @ing3.id)
    DishIngredient.create(dish_id: @dish110.id, ingredient_id: @ing3.id)
    DishIngredient.create(dish_id: @dish111.id, ingredient_id: @ing3.id)
    DishIngredient.create(dish_id: @dish110.id, ingredient_id: @ing4.id)
    DishIngredient.create(dish_id: @dish111.id, ingredient_id: @ing4.id)
    DishIngredient.create(dish_id: @dish2.id, ingredient_id: @ing5.id)
  end
  it "uniq_ingredients" do
    expect(@chef1.uniq_ingredients).to eq([@ing1.name, @ing2.name, @ing3.name, @ing4.name])
  end

  it "popular_ingredients" do
    expect(@chef1.popular_ingredients).to eq([@ing3.name, @ing2.name, @ing4.name])
  end
  
  

end
