require 'net/http'
require 'json'

class Bittrex

    def self.btc_price
        uri = URI('https://api.bittrex.com/v3/markets/BTC-USD/ticker')
        res = Net::HTTP.get_response(uri)
        price = JSON.parse(res.body)["lastTradeRate"].to_f
    end

end