=begin
 Authors: Maudlin Kummer 11-120-169
          Adrian Kurt 11-108-271
=end

class App
  # To change this template use File | Settings | File Templates.require 'rubygems'
  require 'sinatra'
  require 'tilt/haml'
  require '../app/models/trader/user'
  require '../app/models/trades/item'
  require '../app/controllers/main'
  require '../app/controllers/authentication'
  require '../app/controllers/transaction'

  class App < Sinatra::Base

    use Authentication
    use Main
    use Transaction

    enable :sessions
    set :public_folder, 'app/public'

    configure :development do
      john = Trader::User.named("John")
      berta = Trader::User.named("Berta")
      jamie = Trader::User.named ("Jamie")

      Trader::User.userss.push(john, berta, jamie)

      john.add_item_to_system

      urs.add_item(Traders::Item.create("Hanf",99))
      urs.add_item(Traders::Item.create_active("Hut",13.55))
      urs.add_item(Traders::Item.create_active("Handy",301))

      oli.add_item(Traders::Item.create_active("Velo",221))
      oli.add_item(Traders::Item.create_active("GA",2500))

      adrian.add_item(Traders::Item.create("Schwedische Penispumpe",123) )
      adrian.add_item(Traders::Item.create_active("Huhn",22))
      adrian.add_item(Traders::Item.create_active("Auto",21000))

      kenneth.add_item(Traders::Item.create_active("Einhorn",10000))
      kenneth.add_item(Traders::Item.create_active("lustige Pilze",101))
      kenneth.add_item(Traders::Item.create_active("Bong",500))
    end

  end

# Now, run it
  App.run!
end