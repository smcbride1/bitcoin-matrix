class UsersController < ApplicationController

    get "/login" do
        erb :login
    end

    post "/login" do
        user = user.find_by(email: params[:email])
        if user.authenticate(params[:password])
            sessions[:user_id] = user.id
            redirect "/trade"
        else
            @email = params[:email]
            @error_message = "Your email or password is incorrect. Please try again."
            get "/login"
        end
    end

    get "/signup" do
    end

    post "/signup" do
    end

    get "/logout" do
    end

    get "/users/new" do
    end

    post "/users" do
    end

    get "/users/:id" do
    end

    get "/users/:id/edit" do
    end

    patch "/users/:id" do
    end

    delete "/users/:id" do
    end

end