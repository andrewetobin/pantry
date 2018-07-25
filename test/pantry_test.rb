require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'

class PantryTest < Minitest::Test

  def setup
    @pantry = Pantry.new
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

end
# pantry = Pantry.new
# # => <Pantry...>
#
# # Checking and adding stock
# pantry.stock
# # => {}
#
# pantry.stock_check("Cheese")
# # => 0
#
# pantry.restock("Cheese", 10)
# pantry.stock_check("Cheese")
# # => 10
#
# pantry.restock("Cheese", 20)
# pantry.stock_check("Cheese")
# # => 30
# ```
