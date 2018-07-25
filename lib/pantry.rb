class Pantry
  attr_reader :stock, :shopping_list, :cookbook



  def initialize
    @stock = Hash.new(0)
    @shopping_list = Hash.new(0)
    @cookbook = []
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

  def add_to_cookbook(recipe)
    @cookbook << recipe
  end

  def what_can_i_make
    recipes_in_stock.map do |recipe|
      recipe.name
    end
  end

  def recipes_in_stock
    @cookbook.find_all do |recipe|
      recipe.ingredients.all? do |ingredient, amount_required|
        @stock[ingredient] >= amount_required
      end
    end
  end

  def how_many_can_i_make
    recipes_in_stock.inject({}) do |how_many, recipe|
      how_many[recipe.name] = amount_available(recipe)
      how_many
    end
  end

  def amount_available(recipe)
    tallies = recipe.ingredients.map do |ingredient, amount_required|
      @stock[ingredient] / amount_required
    end
    tallies.min_by do |ingredient, amount|
      amount
    end
  end
end
