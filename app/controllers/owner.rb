
require 'tilt/haml'
require 'app/models/trade/user'

class Owner
  # To change this template use File | Settings | File Templates.
  get "/owner" do
    haml :own
  end
end