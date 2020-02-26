require "minitest/autorun"
require "./lib/item.rb"
class ItemTest < Minitest::Test

  def test_it_exists
    assert_instance_of Item, Item.new({name: 'Peach', price: "$0.75"})
  end

  def test_it_has_a_name
    item2 = Item.new({name: 'Tomato', price: '$0.50'})
    assert_equal "Tomato", item2.name
  end

  def test_it_has_a_price
    item2 = Item.new({name: 'Tomato', price: '$0.50'})
    assert_equal 0.50, item2.price
  end

end
