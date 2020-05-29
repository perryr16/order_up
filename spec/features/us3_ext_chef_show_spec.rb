require 'rails_helper'

RSpec.describe "US3 & EXT", type: :feature do
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
    DishIngredient.create(dish_id: @dish100.id, ingredient_id: @ing3.id)
    DishIngredient.create(dish_id: @dish110.id, ingredient_id: @ing2.id)
    DishIngredient.create(dish_id: @dish110.id, ingredient_id: @ing3.id)
    DishIngredient.create(dish_id: @dish110.id, ingredient_id: @ing4.id)
    DishIngredient.create(dish_id: @dish111.id, ingredient_id: @ing3.id)
    DishIngredient.create(dish_id: @dish111.id, ingredient_id: @ing4.id)
    DishIngredient.create(dish_id: @dish2.id, ingredient_id: @ing5.id)
  end

  it "chef show page has name and ingredients link" do
    visit chef_path(@chef1)

    within("#chef-info")do
      expect(page).to have_content(@chef1.name)
      expect(page).to_not have_content(@chef2.name)
      click_link("Chef's Ingredients")
    end
    expect(current_path).to eq(chef_ingredients_path(@chef1))
  end
  
  it "chef ingredient index has uniq list of used ingredients" do
    visit chef_ingredients_path(@chef1)

    within("#ing-list")do
      expect(page).to have_content("Ingredients Used By #{@chef1.name}")
      expect(page).to have_content(@ing1.name, count: 1)
      expect(page).to have_content(@ing2.name, count: 1)
      expect(page).to have_content(@ing3.name, count: 1)
      expect(page).to have_content(@ing4.name, count: 1)
      expect(page).to_not have_content(@ing5.name)
    end
  end
  
  it "chef show page has three most popular ingredients" do
    visit chef_path(@chef1)

    # ing 3 used 3
    # ing 2 used 2, tie goes to who ever show sup first...
    # ing 4 used 2
    within("#popular-ingredients")do
      expect(page).to have_content("3 Most Popular Ingredients in #{@chef1.name}'s Dishes")
      expect(page.all('li')[0]).to have_content(@ing3.name)
      expect(page.all('li')[1]).to have_content(@ing2.name)
      expect(page.all('li')[2]).to have_content(@ing4.name)
      expect(page).to_not have_content(@ing1.name)
      expect(page).to_not have_content(@ing5.name)
    end
  end
  

end

# Extension
# As a visitor
# When I visit a chef's show page
# I see the three most popular ingredients that the chef uses in their dishes
# (Popularity is based off of how many dishes use that ingredient)

