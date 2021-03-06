=begin
 Authors: Maudlin Kummer 11-120-169
          Adrian Kurt 11-108-271
=end

module Trade

  class User

    @@users = Array.new
    attr_accessor :name, :credits, :items

    def self.named(name)
      self.new(name)
    end

    def initialize(name)
      self.name = name
      self.credits = 100
      self.items= Array.new
    end

    def to_s
      self.name
    end

    def payable?(amount)
      self.credits >= amount
    end

    def pay(amount)
      self.credits -= amount
    end

    def receive_money(amount)
      self.credits += amount
    end

    def item_add (item)
      self.items.push(item)
    end

    def item_remove(item)
      self.items.delete(item)
    end

    def activate_for_sale(item)
      item.set_active
    end

    def deactivate(item)
      item.set_inactive
    end

    def add_item_to_system (item, price)
      item_add(Item.new(item, price, self.name))
    end

    def buy_from (item, user)
      fail 'Not for sale' if not item.buyable?
      fail 'Not enough money' if not payable?(item.price)
          user.item_remove(item)
          pay(item.price)
          user.receive_money(item.price)
          item_add(item)
          item.owner = self.name
          deactivate(item)

    end

    def list_active_items
     self.items.select{|i| i.buyable? == true}
    end

    def all_items
      item_list = Array []
      items.each{|item| item_list.push(item)}
      item_list
    end

    def save
      @@users.push(self)
    end

    def self.all
      @@users
    end

    def self.by_name name
      @@users.detect { |user| user.name == name }
    end
  end
end