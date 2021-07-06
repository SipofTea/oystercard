class Oystercard
attr_reader :balance
MAX_BALANCE = 90

    def initialize
        @balance = 0
       
    end
    def top_up(amount)
        if @balance + amount > MAX_BALANCE then raise "Balance exceeds maximum amount (#{MAX_BALANCE})" else @balance = @balance + amount end
    end
end