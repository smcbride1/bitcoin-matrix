require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "zMIxM2uDYDXEdg90TitT"
  end

  get "/" do
    erb :index
  end

  get "/trade" do
    erb :trade
  end

  helpers do
    def logged_in?
      session.has_key?(:user_id)
    end

    def current_user
      User.find(session[:user_id])
    end
  end
  
end
