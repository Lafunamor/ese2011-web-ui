=begin
 Authors: Maudlin Kummer 11-120-169
          Adrian Kurt 11-108-271
=end

require "test/unit"
require "../app/models/trade/item"
require "../app/models/trade/user"

class ItemTest < Test::Unit::TestCase

  def test_constructor
    user = Trade::User.named("Poddrick")
    item = Trade::Item.new("Eis", 12, user)

    assert_equal(item.name, "Eis")
    assert_equal(item.price, 12)
    assert_equal(item.owner, user )
    assert_equal(item.owner.name, "Poddrick")

  end

  def test_switching_state
    item = Trade::Item.new("Book", 30, "Joe")
    assert_equal(item.state, false)
    item.set_active
    assert_equal(item.state, true)
    item.set_inactive
    assert_equal(item.state, false)
  end

  def test_item_buyable
    item = Trade::Item.new("Book", 30, "Joe")
    assert_equal(item.state, false)
    item.set_active
    assert(item.buyable?, 'Item can be bought.')
  end

end