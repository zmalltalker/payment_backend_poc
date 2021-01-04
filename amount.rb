class Amount 
    include Comparable
    attr_reader :amount

    def <=>(another)
        @amount <=> another.amount
    end

    def initialize(currency, amount)
        @currency = currency
        @amount = amount.to_i
    end

    def to_s
        dollars = @amount/100
        cents = @amount % 100
        "#{dollars}.#{cents} #{currency_code}"
    end

    def currency_code
        @currency.to_s.upcase[0,3]
    end

    def self.crosses
        {nok: 1.2, rebel: 1.0}
    end

    def to_currency(currency)
        factor = self.class.crosses[@currency]
        self.class.new(currency, @amount*factor)
    end
end
