=begin
 Authors: Maudlin Kummer 11-120-169
          Adrian Kurt 11-108-271
=end

require 'tilt/haml'


class Main < Sinatra::Application

  get "/" do

    redirect '/login' unless session[:name]

    haml :list_users, :locals => { :time => Time.now ,
                                      :users => User.all,
                                      :current_name => session[:name] }
  end

end