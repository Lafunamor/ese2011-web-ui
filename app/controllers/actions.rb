
=begin
    Authors: Maudlin Kummer 11-120-169
    Adrian Kurt 11-108-271
=end

  require 'tilt/haml'
  require '../app/models/trade/user'
  require '../app/models/trade/item'

  class Actions < Sinatra::Application

   get "/buy" do
     redirect "/"
   end

    post "/buy" do
      owner_name = params[:owner]
      item_name = params[:item_name]
      user_name = session[:name]

      owner=Trade::User.by_name(owner_name)
      user = Trade::User.by_name(user_name)
      item=owner.items.detect { |it| it.name == item_name }

      fail "Item not found!" if item == nil

      user.buy_from(item,owner)

      redirect "/"
    end

    get "/activate" do
      redirect "/"
    end

    post "/activate" do
      item_name = params[:item_name]
      user_name = session[:name]

      user =Trade::User.by_name(user_name)
      item=owner.items.detect { |it| it.name == item_name }
      item.set_active

      redirect "/"
    end

  end
