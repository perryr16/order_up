require 'rails_helper'

RSpec.describe "US1", type: :feature do
  before :each do
    @chef1 = Chef.create(name: "Chef1")
    @chef2 = Chef.create(name: "Chef2")
    @dish1 = @chef1.dishes.create(name: "Dish1", description: "description1")
    @dish2 = @chef2.dishes.create(name: "Dish2", description: "description2")
    @ing1 = Ingredient.create(name: "Ingredient1", calories: 100)
    @ing2 = Ingredient.create(name: "Ingredient2", calories: 200)
    @ing3 = Ingredient.create(name: "Ingredient3", calories: 300)

    DishIngredient.create(dish_id: @dish1.id, ingredient_id: @ing1.id)
    DishIngredient.create(dish_id: @dish1.id, ingredient_id: @ing2.id)
    DishIngredient.create(dish_id: @dish1.id, ingredient_id: @ing3.id)
  end

  it "dish show page has ingredients" do
    visit dish_path(@dish1)

    within("#dish-info")do
      expect(page).to have_content(@dish1.name)
      expect(page).to_not have_content(@dish2.name)
      expect(page).to have_content(@dish1.description)
      expect(page).to_not have_content(@dish2.description)
      expect(page).to have_content("Chef: #{@chef1.name}")
      expect(page).to_not have_content("Chef: #{@chef2.name}")
    end

    within("#ing-#{@ing1.id}")do
      expect(page).to have_content("#{@ing1.name}: #{@ing1.calories} calories")
      expect(page).to_not have_content("#{@ing2.name}: #{@ing2.calories} calories")
    end
    within("#ing-#{@ing2.id}")do
      expect(page).to have_content("#{@ing2.name}: #{@ing2.calories} calories")
      expect(page).to_not have_content("#{@ing3.name}: #{@ing3.calories} calories")
    end
    within("#ing-#{@ing3.id}")do
      expect(page).to have_content("#{@ing3.name}: #{@ing3.calories} calories")
      expect(page).to_not have_content("#{@ing2.name}: #{@ing2.calories} calories")
    end
  end

  it "us2" do
     visit dish_path(@dish1)
     
     within("#total-calories")do
       expect(page).to have_content("Total Calories: #{@dish1.total_calories}")
     end
  end
end

# Story 2 of 3
# As a visitor
# When I visit a dish's show page
# I see the total calorie count for that dish.