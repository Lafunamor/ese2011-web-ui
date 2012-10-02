=begin
 Authors: Maudlin Kummer 11-120-169
          Adrian Kurt 11-108-271
=end

require 'tilt/haml'
require 'app/models/trade/user'

class Main < Sinatra::Application

  get "/" do

    redirect '/login' unless session[:name]

    haml :home, :locals => { :time => Time.now ,
                                      :users => Trade::User.all,
                                      :current_name => session[:name] }
  end

end