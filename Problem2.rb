require 'httparty'
require 'json'

def fetch_market_data
  response = HTTParty.get("https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd")
  JSON.parse(response.body)
end

def top_cryptocurrencies(market_data)
  sorted_cryptos = market_data.sort_by { |crypto| -crypto['market_cap'] }
  sorted_cryptos.take(5)
end

def display_top_cryptocurrencies(cryptos)
  puts "Top 5 Cryptocurrencies by Market Cap:"
  cryptos.each do |crypto|
    puts "Name: #{crypto['name']}"
    puts "Price: #{crypto['current_price']} USD"
    puts "Market Cap: #{crypto['market_cap']} USD"
    puts "----------------------------------------"
  end
end

market_data = fetch_market_data
top_cryptos = top_cryptocurrencies(market_data)
display_top_cryptocurrencies(top_cryptos)
