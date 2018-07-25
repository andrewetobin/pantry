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

end
