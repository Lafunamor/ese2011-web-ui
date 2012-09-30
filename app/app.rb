=begin
 Authors: Maudlin Kummer 11-120-169
          Adrian Kurt 11-108-271
=end

  require 'rubygems'
  require 'sinatra'
  require 'tilt/haml'
  require './models/trade/user'
  require './models/trade/item'
  require './controllers/main'
  require './controllers/authentication'

  class App < Sinatra::Base

    use Authentication
    use Main

    enable :sessions
    set :public_folder, 'app/public'

    configure :development do
      john = User.named("John")
      berta =User.named("Berta")
      jamie =User.named("Jamie")
      ese = User.named("ESE")

      john.save
      berta.save
      jamie.save
      ese.save

      john.add_item_to_system("Topf",12)
      john.add_item_to_system("Tasche_Gucci", 99)

      berta.add_item_to_system("Stuhl", 50)
      berta.add_item_to_system("Tisch", 66)

      jamie.add_item_to_system("Schwert", 250)
      jamie.add_item_to_system("Schild", 33)

      ese.add_item_to_system("Ruby_Buch", 0)
      ese.add_item_to_system("RubyMine Key", 22)


    end


# Now, run it
  App.run!
end