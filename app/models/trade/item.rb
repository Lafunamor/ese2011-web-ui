=begin
 Authors: Maudlin Kummer 11-120-169
          Adrian Kurt 11-108-271
=end

module Trade

  class Item
    attr_accessor :price, :name, :state, :owner

    def self.create(name, price, owner)
      initialize(name, price, owner)
      self
    end

    def initialize (name, price, owner)
      self.name= name
      self.price=price
      self.state= false
      self.owner=owner
    end

    def set_inactive
      self.state=false
    end

    def set_active
      self.state=true
    end

    def buyable?
      if (self.state == true)
        true
      else
        false
      end
    end


  end
end