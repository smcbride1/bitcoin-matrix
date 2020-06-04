class TransactionsController < ApplicationController

    get "/transactions" do

        return redirect "/login" if !logged_in?
        @transactions = current_user.transactions
        erb :"transactions/index"

    end

    get "/transactions/:id" do

        return redirect "/login" if !logged_in?
        @transaction = Transaction.find(params[:id])
        return redirect "/transactions" if current_user != @transaction.wallet.user
        erb :"transactions/show"

    end

end