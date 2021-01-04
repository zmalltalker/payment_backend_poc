require "pathname"
require "securerandom"
class Account

    class InvalidTransaction < StandardError
    end

    def initialize(account_number = SecureRandom.uuid)
        @account_number = account_number
        @transactions = []
    end
    
    def load(transactions)
        transactions.each do |t|
            currency, amount = t
            deposit(currency, amount)
        end
    end

    def pathname
        Pathname("./data/#{@account_number}.csv")
    end

    def dump_state
        File.open(pathname, "w") do |f|
            @transactions.each do |currency, amount|
                f.write("#{currency};#{amount}\n")
            end
        end
    end

    # Clear all transactions, load state from file
    def reset_state
        @transactions = []
        lines = File.readlines(pathname).each do |line|
            currency, amount = line.split(";")
            deposit(currency.to_sym, Float(amount))
        end
    end

    def deposit(currency, cents, debug = false)
        @transactions << [currency, cents]
        if debug
            amt = Currency.new(currency, cents)
            puts "Depositing #{amt}, balance is #{balance}"
        end
    end

    def withdraw(currency, cents, debug=false)
        b = balance
        factor = Currency.crosses[currency]
        requested = Currency.new(:rebel, (factor * cents))
        if debug
            puts "Trying to withdraw #{requested}, balance is #{balance}"
        end
        if b >= requested
            deposit(currency, -cents, false)
            puts "Withdrawal of #{requested} is allowed"
        else 
            raise InvalidTransaction, "Withdrawal of #{requested} denied, balance is #{balance}"            
            puts "Withdrawal of #{requested} is denied"
        end
    end

    def balance
        result = 0
        @transactions.map do |t|
            currency, amount = t
            factor = Currency.crosses[currency]
            if factor.nil?
                raise "Invalid factor for currency #{currency}, looked in #{Currency.crosses}"
            end
            result += factor*amount
        end
        Currency.new(:rebel, result)
    end
end
