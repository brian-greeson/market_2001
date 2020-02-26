require "./lib/item"

class Vendor
  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def check_stock(item)
    @inventory[item]
  end

  def stock(item, amount)
    @inventory.has_key?(item) ? @inventory[item] += amount : @inventory[item] = amount
  end

  def items_in_stock
    @inventory.select { |item_name, amount| amount > 0 }.keys

  end

  def potential_revenue
    @inventory.map { |item, amount| item.price * amount }.sum
  end
end
