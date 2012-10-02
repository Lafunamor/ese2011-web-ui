=begin
 Authors: Maudlin Kummer 11-120-169
          Adrian Kurt 11-108-271
=end

require 'tilt/haml'
require 'app/models/trade/user'

class Authentication < Sinatra::Application
  # To change this template use File | Settings | File Templates.
  get "/login" do
    haml :login
  end

  post "/login" do
    name = params[:username]
    password = params[:password]

    fail "Username is empty" if name.nil?
    fail "Password is empty" if password.nil?

    user = User.by_name name

    fail "Username or password are not valid" if student.nil? or password != name

    session[:name] = name
    redirect '/'
  end

  get "/logout" do
    session[:name] = nil
    redirect '/login'
  end
end