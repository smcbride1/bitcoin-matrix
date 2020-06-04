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

        @wallet = Wallet.find(params[:id])
        return redirect "/wallets" if @wallet.user != current_user

        erb :"wallets/transactions"

    end

    get "/wallets/:id/trade" do

        @wallet = Wallet.find(params[:id])
        return redirect "/wallets" if @wallet.user != current_user

        erb :"wallets/trade"

    end

    post "/wallets/:id/buy" do

        btc_price = Bittrex.btc_price
        amount = params[:buy_amount].to_f
        wallet = Wallet.find(params[:id])
        return redirect "/wallets" if wallet.user != current_user

        return redirect "/wallets/#{wallet.id}/trade" if 0 >= wallet.usd_balance #Makes sure usd balance is greater than 0
        return redirect "/wallets/#{wallet.id}/trade" if amount > (wallet.usd_balance / btc_price) #Makes sure desired buy amount is not greater than balance

        Transaction.create(wallet_id: wallet.id, order_type: "buy", amount: amount, price: btc_price)
        wallet.update(usd_balance: (wallet.usd_balance - amount * btc_price))
        wallet.update(btc_balance: (wallet.btc_balance + amount))

        redirect "/wallets/#{wallet.id}/trade"

    end

    post "/wallets/:id/sell" do

        btc_price = Bittrex.btc_price
        amount = params[:sell_amount].to_f
        wallet = Wallet.find(params[:id])
        return redirect "/wallets" if wallet.user != current_user

        return redirect "/wallets/#{wallet.id}/trade" if 0 >= wallet.btc_balance #Makes sure btc balance is greater than 0
        return redirect "/wallets/#{wallet.id}/trade" if amount > wallet.btc_balance #Makes sure desired sell amount is not greater than balance

        Transaction.create(wallet_id: wallet.id, order_type: "sell", amount: amount, price: btc_price)
        wallet.update(btc_balance: (wallet.btc_balance - amount))
        wallet.update(usd_balance: (wallet.usd_balance + (amount * btc_price)))

        redirect "/wallets/#{wallet.id}/trade"

    end

end