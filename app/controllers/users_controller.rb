class UsersController < ApplicationController

    get "/login" do
        return redirect "/wallets" if logged_in? #Prevents login if already logged in
        erb :"users/login"
    end

    post "/login" do
        user = User.find_by(email: params[:email])
        if user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/wallets"
        else
            redirect "/login"
        end
    end

    get "/signup" do
        return redirect "/wallets" if logged_in? #Prevents sign up if already logged in
        erb :"users/new"
    end

    post "/signup" do
        user = User.create(name: params[:name], username: params[:username], email: params[:email], password: params[:password])
        if user.valid?
            session[:user_id] = user.id
            redirect "/wallets"
        else
            redirect "/signup" 
        end
    end

    get "/logout" do
        session.destroy
        redirect "/login"
    end

    get "/users/:id" do
        @user = User.find(params[:id])
        erb :"users/show"
    end

    get "/users/:id/edit" do
        @user = User.find(params[:id])
        erb :"users/edit"
    end

    patch "/users/:id" do
        return redirect "/login" if current_user.id != params[:id] #Checks permissions
        user = User.find(params[:id])
        user.update(name: params[:name], username: params[:username], email: params[:email], password: params[:password])
        if user.valid?
            session[:user_id] = user.id
            redirect "/users/#{params[:id]}/edit"
        else
            redirect "/users/#{params[:id]}/edit"
        end
    end

    delete "/users/:id" do
        return redirect "/login" if current_user.id != params[:id]
        User.find(params[:id]).destroy
        redirect "/"
    end

end