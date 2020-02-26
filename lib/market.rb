require "./lib/item"
require "./lib/vendor"

class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map { |vendor| vendor.name  }
  end

  def vendors_that_sell(item)
    @vendors.select { |vendor| vendor.items_in_stock.include?(item) }
  end

  def sorted_item_list
    all_items =[]
    @vendors.each do |vendor|
      all_items << vendor.items_in_stock
    end
    all_items = all_items.flatten.map {|item| item.name}.uniq
    all_items.sort
  end



  def total_inventory
    # require "pry"; binding.pry
    all_items = sorted_item_list
    all_items.reduce({}) do |acc, item|
      acc[item] = {
                    quanity: total_quantity(item),
                    vendors: vendors_that_sell(item)
                  }
      acc
    end
  end

end
