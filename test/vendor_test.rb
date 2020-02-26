require "minitest/autorun"

require "./lib/vendor"

class VendorTest < Minitest::Test

  def setup
    @vendor = Vendor.new("Rocky Mountain Fresh")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
  end
  def test_it_exists
    assert_instance_of Vendor, @vendor
  end

  def test_it_has_a_name
    assert_equal "Rocky Mountain Fresh", @vendor.name
  end

  def test_it_starts_with_empty_inventory
    assert_equal ({}), @vendor.inventory
  end

  def test_it_non_stocked_items_have_stock_level_of_0
    assert_equal 0, @vendor.check_stock(@item1)
  end

  def test_it_can_add_stock
    @vendor.stock(@item1, 30)

    assert_equal ({@item1 => 30}), @vendor.inventory
  end

  def test_it_can_add_more_stock
    @vendor.stock(@item1, 30)

    assert_equal ({@item1 => 30}), @vendor.inventory

    @vendor.stock(@item1, 25)

    assert_equal 55, @vendor.check_stock(@item1)
  end

  def test_it_can_stock_multiple_items
    @vendor.stock(@item1, 30)
    @vendor.stock(@item1, 25)
    @vendor.stock(@item2, 12)

    assert_equal ({
                    @item1 => 55,
                    @item2 => 12
                  }), @vendor.inventory
  end

end
