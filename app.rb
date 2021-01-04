require "bundler/setup"
require "sinatra"
require "./account"
require "./amount"
Acct = Account.new("sinatra")
Acct.reset_state

get "/" do
    #content_type :json
    #Acct.balance
    #{"foo": "12"}
    Acct.reset_state
    "Hello world: #{Acct.balance}"
end

post "/:currency/:amount" do
    Acct.deposit(params[:currency].to_sym, params[:amount].to_i)
    Acct.dump_state
    "Hello world: #{Acct.balance}"
end