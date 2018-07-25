require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/recipe'

class PantryTest < Minitest::Test

  def setup
    @pantry = Pantry.new
    @recipe_1 = Recipe.new("Cheese Pizza")
    @recipe_2 = Recipe.new("Spaghetti")

  end

  def test_it_exists
    assert_instance_of Pantry, @pantry
  end

  def test_it_starts_empty
    assert_equal ({}), @pantry.stock
  end

  def test_stock_check
    assert_equal 0, @pantry.stock_check("Cheese")
  end

  def test_it_can_restock
    assert_equal 10, @pantry.restock("Cheese", 10)
    @pantry.restock("Cheese", 20)
    @pantry.stock_check("Cheese")
    assert_equal 30, @pantry.stock_check("Cheese")
  end

  def test_shopping_list_starts_out_empty
    assert_equal ({}), @pantry.shopping_list
  end

  def test_it_can_add_recipes_to_shopping_list
    @recipe_1.add_ingredient("Cheese", 20)
    @recipe_1.add_ingredient("Flour", 20)
    @pantry.add_to_shopping_list(@recipe_1)

    expected = {"Cheese" => 20, "Flour" => 20}
    assert_equal expected, @pantry.shopping_list

    @recipe_2.add_ingredient("Spaghetti Noodles", 10)
    @recipe_2.add_ingredient("Marinara Sauce", 10)
    @recipe_2.add_ingredient("Cheese", 5)
    @pantry.add_to_shopping_list(@recipe_2)

    expected = {"Cheese" => 25, "Flour" => 20, "Spaghetti Noodles" => 10, "Marinara Sauce" => 10}

    assert_equal expected, @pantry.shopping_list
  end

  def test_it_can_print_shopping_list
    @recipe_1.add_ingredient("Cheese", 20)
    @recipe_1.add_ingredient("Flour", 20)
    @pantry.add_to_shopping_list(@recipe_1)
    @recipe_2.add_ingredient("Spaghetti Noodles", 10)
    @recipe_2.add_ingredient("Marinara Sauce", 10)
    @recipe_2.add_ingredient("Cheese", 5)
    @pantry.add_to_shopping_list(@recipe_2)

    expected = "* Cheese: 25\n* Flour: 20\n* Spaghetti Noodles: 10\n* Marinara Sauce: 10"

    assert_equal expected, @pantry.print_shopping_list
  end

  def test_what_can_be_made
    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)

    r2 = Recipe.new("Pickles")
    r2.add_ingredient("Brine", 10)
    r2.add_ingredient("Cucumbers", 30)

    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)

    @pantry.add_to_cookbook(r1)
    @pantry.add_to_cookbook(r2)
    @pantry.add_to_cookbook(r3)

    @pantry.restock("Cheese", 10)
    @pantry.restock("Flour", 20)
    @pantry.restock("Brine", 40)
    @pantry.restock("Cucumbers", 120)
    @pantry.restock("Raw nuts", 20)
    @pantry.restock("Salt", 20)

    assert_equal ["Pickles", "Peanuts"], @pantry.what_can_i_make
  end





end
# pantry = Pantry.new
#
# # Building our recipe
# r1 = Recipe.new("Cheese Pizza")
# r1.add_ingredient("Cheese", 20)
# r1.add_ingredient("Flour", 20)
#
# r2 = Recipe.new("Pickles")
# r2.add_ingredient("Brine", 10)
# r2.add_ingredient("Cucumbers", 30)
#
# r3 = Recipe.new("Peanuts")
# r3.add_ingredient("Raw nuts", 10)
# r3.add_ingredient("Salt", 10)
#
#
# # Adding the recipe to the cookbook
# pantry.add_to_cookbook(r1)
# pantry.add_to_cookbook(r2)
# pantry.add_to_cookbook(r3)
#
# # Stock some ingredients
# pantry.restock("Cheese", 10)
# pantry.restock("Flour", 20)
# pantry.restock("Brine", 40)
# pantry.restock("Cucumbers", 120)
# pantry.restock("Raw nuts", 20)
# pantry.restock("Salt", 20)
#
# # What can I make?
# pantry.what_can_i_make # => ["Pickles", "Peanuts"]
#
# # How many can I make?
# pantry.how_many_can_i_make # => {"Pickles" => 4, "Peanuts" => 2}
# ```
