=begin
    Authors: Maudlin Kummer 11-120-169
    Adrian Kurt 11-108-271
=end

require 'tilt/haml'
require '../app/models/trade/user'

class Owner < Sinatra::Application

  get "/owner" do
    redirect '/'
  end

  post "/owner" do
    if params[:user] == nil
      redirect '/'
    end
    haml :owner , :locals => {:owner => Trade::User.by_name(params[:user])}

  end
end