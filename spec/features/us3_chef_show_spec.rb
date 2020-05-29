require 'rails_helper'

RSpec.describe "US3", type: :feature do
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

  it "chef show page has name and ingredients link" do
    visit chef_path(@chef1)

    within("#chef-info")do
      expect(page).to have_content(@chef1.name)
      click_link("Chef's Ingredients")
    end
    expect(current_path).to eq(chef_ingredients_path(@chef1))
  end
  

end


# Story 3 of 3
# As a visitor
# When I visit a chef's show page
# I see the name of that chef
# And I see a link to view a list of all
  # ingredients that this chef uses in their dishes
# When I click on that link
# I'm taken to a chef's ingredient index page
# and I can see a unique list of names of all the ingredients that this chef uses