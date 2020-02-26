require "minitest/autorun"
require "./lib/market"


class MarketTest < Minitest::Test

  def setup
    @market = Market.new("South Pearl Street Farmers Market")

    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @vendor2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor3 = Vendor.new("Palisade Peach Shack")

    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)
  end

  def test_it_exists
    assert_instance_of Market, @market
  end

  def test_it_has_a_name
    assert_equal "South Pearl Street Farmers Market", @market.name
  end

  def test_it_starts_with_no_vendors
    assert_equal ([]), @market.vendors
  end

  def test_it_can_add_vendors
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)

    assert_equal [@vendor1, @vendor2, @vendor3], @market.vendors
  end

  def test_it_can_list_vendor_names
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)

    expected_names = [
                      "Rocky Mountain Fresh",
                      "Ba-Nom-a-Nom",
                      "Palisade Peach Shack"
                      ]

    assert_equal  expected_names, @market.vendor_names
  end

  def test_it_can_list_vendors_that_sell_item
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)

    assert_equal [@vendor1, @vendor3], @market.vendors_that_sell(@item1)
    assert_equal [@vendor2], @market.vendors_that_sell(@item4)
  end

  def test_it_lists_total_inventory
    @vendor3.stock(@item3, 10)
    expected_inventory = {
                          @item1 => {
                                    quantity: 100,
                                    vendors: [@vendor1, @vendor3]
                                    },
                          @item2 => {
                                    quantity: 7,
                                    vendors: [@vendor1]
                                    },
                          @item4 => {
                                    quantity: 50,
                                    vendors: [@vendor2]
                                    },
                          @item3 => {
                                    quantity: 35,
                                    vendors: [@vendor2, @vendor3]
                                    }
                          }

    assert_equal expected_inventory, @market.total_inventory
  end

end




# pry(main).overstocked_items
# #=> [#<item1...>]
#
# pry(main)> market.sorted_item_list
# #=> ["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"]



#
# pry(main)> market = Market.new("South Pearl Street Farmers Market")
# #=> #<Market:0x00007fe134933e20...>
#
# pry(main)> item1 = Item.new({name: 'Peach', price: "$0.75"})
# #=> #<item1...>
#
# pry(main)> item2 = Item.new({name: 'Tomato', price: '$0.50'})
# #=> #<item2...>
#
# pry(main)> item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
# #=> #<item3...>
#
# pry(main)> item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
# #=> #<item4...>
#
# pry(main)> vendor1 = Vendor.new("Rocky Mountain Fresh")
# #=> #<vendor1...>

#
# pry(main)> vendor1.stock(item1, 35)
#
# pry(main)> vendor1.stock(item2, 7)
#
# pry(main)> vendor2 = Vendor.new("Ba-Nom-a-Nom")
# #=> #<vendor2...>
#
# pry(main)> vendor2.stock(item4, 50)
#
# pry(main)> vendor2.stock(item3, 25)
#
# pry(main)> vendor3 = Vendor.new("Palisade Peach Shack")
# #=> #<vendor3...>
#
# pry(main)> vendor3.stock(item1, 65)
#
# pry(main)> vendor3.stock(item3, 10)
#
# pry(main)> market.add_vendor(vendor1)
#
# pry(main)> market.add_vendor(vendor2)
#
# pry(main)> market.add_vendor(vendor3)
#
# pry(main)> market.total_inventory
# #=> {
#   #   #<item1...> => {
#   #     quantity: 100,
#   #     vendors: [#<vendor1...>, #<vendor3...>]
#   #   },
#   #   #<item2...> => {
#   #     quantity: 7,
#   #     vendors: [#<vendor1...>]
#   #   },
#   #   #<item4...> => {
#   #     quantity: 50,
#   #     vendors: [#<vendor2...>]
#   #   },
#   #   #<item3...> => {
#   #     quantity: 35,
#   #     vendors: [#<vendor2...>, #<vendor3...>]
#   #   },
#   # }
#
