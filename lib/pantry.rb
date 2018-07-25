class Pantry
  attr_reader :stock
  attr_reader :shopping_list

  def initialize
    @stock = Hash.new(0)
    @shopping_list = Hash.new(0)
  end

  def stock_check(item)
    @stock[item]
  end

  def restock(item, amount)
    @stock[item] += amount
  end

  def add_to_shopping_list(recipe)
    recipe.ingredients.each do |item, amount|
      @shopping_list[item] += amount
    end
  end

  def print_shopping_list
    list = []
    @shopping_list.each do |key, value|
      list << "* #{key}: #{value}"
    end
    list.join("\n")
  end






end
