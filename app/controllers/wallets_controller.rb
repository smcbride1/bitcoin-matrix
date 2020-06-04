class WalletsController < ApplicationController

    get "/wallets" do
        return redirect "/login" if !logged_in? #Checks permissions
        @user = current_user
        erb :"wallets/index"
    end

    get "/wallets/new" do
        return redirect "/login" if !logged_in? #Checks permissions
        erb :"wallets/new"
    end

    post "/wallets" do
        
        if params[:restriction_type] == "competitive"
            btc_balance = 0
            usd_balance = 10000
        elsif params[:restriction_type] == "casual"
            btc_balance = params[:btc_balance]
            usd_balance = params[:usd_balance]
        else
            return redirect "/wallets/new"
        end

        wallet = Wallet.create(user_id: session[:user_id], name: params[:name], restriction_type: params[:restriction_type], btc_balance: btc_balance, usd_balance: usd_balance)

        if wallet.valid?
            redirect "/wallets/#{wallet.id}"
        else
            redirect "/wallets/new"
        end

    end

    get "/wallets/:id" do
        @wallet = Wallet.find(params[:id])
        return redirect "/wallets" if @wallet.user != current_user
        erb :"wallets/show"
    end

    get "/wallets/:id/edit" do
        @wallet = Wallet.find(params[:id])
        return redirect "/wallets" if @wallet.user != current_user
        erb :"wallets/edit"
    end

    patch "/wallets/:id" do

        wallet = Wallet.find(params[:id])
        return redirect "/wallets" if wallet.user != current_user

        if wallet.restriction_type == "competitive"
            btc_balance = wallet.btc_balance
            usd_balance = wallet.usd_balance
        elsif wallet.restriction_type == "casual"
            btc_balance = params[:btc_balance]
            usd_balance = params[:usd_balance]
        end

        wallet.update(name: params[:name], btc_balance: btc_balance, usd_balance: usd_balance)

        if wallet.valid?
            redirect "/wallets/#{wallet.id}"
        else
            redirect "/wallets/#{wallet.id}/edit"
        end

    end

    delete "/wallets/:id" do

        wallet = Wallet.find(params[:id])
        return redirect "/wallets" if wallet.user != current_user

        wallet.delete
        redirect "/wallets"

    end

    get "/wallets/:id/transactions" do
    end

end