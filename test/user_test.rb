=begin
 Authors: Maudlin Kummer 11-120-169
          Adrian Kurt 11-108-271
=end

require "test/unit"
require "../app/models/trade/user"
require "../app/models/trade/item"

class UserTest < Test::Unit::TestCase

  def test_constructor
    user = Trade::User.named("Lollys")
    assert_equal(user.name, "Lollys")
    assert_equal(user.credits, 100)
    assert_equal(user.items.size, 0)
  end

  def test_adding_items
    user = Trade::User.named("Jane")
    assert_equal(user.items.size, 0)
    user.add_item_to_system("Book", 30)
    assert_equal(user.items.size, 1)
    user.add_item_to_system("Scarf", 10)
    assert_equal(user.items.size, 2)
    assert_equal(user.items.all? { |item| item.owner == "Jane" }, true)
    assert_equal(user.items.slice(0).name, "Book")
    assert_equal(user.items.slice(1).name, "Scarf")
  end

  def test_removing_items
    user = Trade::User.named("Joe")
    book = Trade::Item.new("Book", 30, "Joe")
    scarf = Trade::Item.new("Scarf", 10, "Joe")
    user.item_add(book)
    user.item_add(scarf)
    assert_equal(user.items.size, 2)
    user.item_remove(scarf)
    assert_equal(user.items.size, 1)
    assert_equal(user.items.slice(0).name, "Book")
  end

  def test_activate_deactivate_item
    user = Trade::User.named("Jane")
    book = Trade::Item.new("Book", 30, "Jane")
    user.item_add(book)
    user.activate_for_sale(book)
    assert_equal(book.state, true)
    user.deactivate(book)
    assert_equal(book.state, false)
  end

  def test_affordable
    user = Trade::User.named("Jane")
    book = Trade::Item.new("Book", 30, "Pete")
    assert(user.payable?(book.price), 'You have enough credits to buy the item.')
  end

  def test_receiving_money
    user = Trade::User.named("Pete")
    assert_equal(user.credits, 100)
    user.receive_money(50)
    assert_equal(user.credits, 150)
  end

  def test_buying_succeeds
    seller = Trade::User.named("Pete")
    buyer = Trade::User.named("Jack")
    book = Trade::Item.new("Book", 20, seller)
    assert_equal(seller.items.size, 0)
    seller.item_add(book)
    assert_equal(seller.items.size, 1)
    seller.activate_for_sale(book)
    buyer.buy_from(book, seller)
    assert_equal(seller.items.size, 0)
    assert_equal(book.owner, "Jack")
    assert_equal(buyer.items.size, 1)
    assert_equal(buyer.items.slice(0).name, "Book")
    assert_equal(book.state, false)
    assert_equal(buyer.credits, 80)
    assert_equal(seller.credits, 120)
  end

  def test_not_for_sale
    seller = Trade::User.named("Pete")
    buyer = Trade::User.named("Jack")
    book = Trade::Item.new("Book", 20, seller)
    assert_equal(seller.items.size, 0)
    seller.item_add(book)
    assert_equal(seller.items.size, 1)
    buyer.buy_from(book, seller)
    assert_equal(seller.items.size, 1)
    assert_equal(buyer.items.size, 0)
    assert_equal(seller.credits, 100)
    assert_equal(buyer.credits, 100)
  end

  def test_not_enough_credits
    seller = Trade::User.named("Pete")
    buyer = Trade::User.named("Jack")
    book = Trade::Item.new("Book", 120, seller)
    assert_equal(seller.items.size, 0)
    seller.item_add(book)
    seller.activate_for_sale(book)
    assert_equal(seller.items.size, 1)
    buyer.buy_from(book, seller)
    assert_equal(seller.items.size, 1)
    assert_equal(buyer.items.size, 0)
    assert_equal(seller.credits, 100)
    assert_equal(buyer.credits, 100)
  end

  def test_just_enough_credits
    seller = Trade::User.named("Pete")
    buyer = Trade::User.named("Jack")
    book = Trade::Item.new("Book", 100, seller)
    assert_equal(seller.items.size, 0)
    seller.item_add(book)
    assert_equal(seller.items.size, 1)
    seller.activate_for_sale(book)
    buyer.buy_from(book, seller)
    assert_equal(seller.items.size, 0)
    assert_equal(book.owner, "Jack")
    assert_equal(buyer.items.size, 1)
    assert_equal(buyer.items.slice(0).name, "Book")
    assert_equal(book.state, false)
    assert_equal(buyer.credits, 0)
    assert_equal(seller.credits, 200)
  end

  def test_listing_active_items
    user = Trade::User.named("Joe")
    user.add_item_to_system("Scarf", 10)
    user.add_item_to_system("Book", 30)
    user.add_item_to_system("TV", 1000)
    user.activate_for_sale(user.items.slice(0))
    user.activate_for_sale(user.items.slice(2))
    assert_equal(user.items.slice(0).state, true)
    assert_equal(user.items.slice(1).state, false)
    assert_equal(user.items.slice(2).state, true)
    assert_equal(user.list_active_items, "Active items:"+"Scarf"+" Price: 10"+"\n"+"TV"+" Price: 1000"+"\n")
  end

end