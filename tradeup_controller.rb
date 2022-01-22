require 'sinatra'
require 'sinatra/json'
require 'Tradeup/Database/Models'
require_relative 'Do-Tradeup-SeedDatabase/seed_database'

class TradeupController < Sinatra::Base
  get '/results' do
    Tradeup::Database::Seeding.connect_to_database
    results = []
    Tradeup::Database::Models::Chain.order_by(amount:-1).limit(20).to_a.map do |sym|
      results << {symbol_one: sym.symbol_one.to_s,
       swap_one: sym.swap_one,
       symbol_two: sym.symbol_two.to_s,
       swap_two: sym.swap_two,
       symbol_three:sym.symbol_three.to_s,
       swap_three: sym.swap_three,
       symbol_four: sym.symbol_four.to_s,
       amount: sym.amount}
    end
    to_render = {result:results,source:'currencyconverterapi.com',response_code: response.status}
    json(to_render)
  end
end