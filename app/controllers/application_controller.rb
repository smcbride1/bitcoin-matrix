require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "zMIxM2uDYDXEdg90TitT"
  end

  get "/" do
    erb :welcome
  end

  get "/trade" do
    erb :trade
  end

end
