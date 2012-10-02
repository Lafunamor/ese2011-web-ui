=begin
 Authors: Maudlin Kummer 11-120-169
          Adrian Kurt 11-108-271
=end

  require 'rubygems'
  require 'sinatra'
  require 'tilt/haml'
  require '../app/models/trade/user'
  require '../app/models/trade/item'
  require '../app/controllers/main'
  require '../app/controllers/authentication'
  require '../app/controllers/actions'
  require '../app/controllers/owner'

  class App < Sinatra::Base

    use Authentication
    use Main
    use Actions
    use Owner

    enable :sessions
    set :public_folder, 'app/public'

    configure :development do
      john = Trade::User.named("John")
      berta = Trade::User.named("Berta")
      jamie = Trade::User.named("Jamie")
      ese = Trade::User.named("ESE")
      ese2 = Trade::User.named("ese")

      john.save
      berta.save
      jamie.save
      ese.save
      ese2.save

      john.add_item_to_system("Topf",12)
      john.add_item_to_system("Tasche_Gucci", 99)

      for item in john.items
        item.set_active
      end

      berta.add_item_to_system("Stuhl", 50)
      berta.add_item_to_system("Tisch", 66)

      for item in berta.items
        item.set_active
      end

      jamie.add_item_to_system("Schwert", 250)
      jamie.add_item_to_system("Schild", 33)

      for item in jamie.items
        item.set_active
      end

      ese.add_item_to_system("Ruby_Buch", 0)
      ese.add_item_to_system("RubyMine Key", 22)

      for item in ese.items
        item.set_active
      end

      ese2.add_item_to_system("ESE0",3)
      ese2.add_item_to_system("^^",66)
      ese2.credits += 999999


    end
  end

# Now, run it
App.run!