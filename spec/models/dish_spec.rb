require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
  end
  describe "relationships" do
    it {should belong_to :chef}
    it {should have_many :dish_ingredients}
    it {should have_many(:ingredients).through(:dish_ingredients)}
  end


  before :each do
    @chef1 = Chef.create(name: "Chef1")
    @dish1 = @chef1.dishes.create(name: "Dish1", description: "description1")
    @ing1 = Ingredient.create(name: "Ingredient1", calories: 100)
    @ing2 = Ingredient.create(name: "Ingredient2", calories: 200)
    @ing3 = Ingredient.create(name: "Ingredient3", calories: 300)

    DishIngredient.create(dish_id: @dish1.id, ingredient_id: @ing1.id)
    DishIngredient.create(dish_id: @dish1.id, ingredient_id: @ing2.id)
    DishIngredient.create(dish_id: @dish1.id, ingredient_id: @ing3.id)
  end

  it "total calories" do
    expect(@dish1.total_calories).to eq(600)
    
  end
  
end
