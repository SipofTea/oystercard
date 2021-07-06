class Oystercard
attr_reader :balance, :in_use
MAX_BALANCE = 90
MIN_BALANCE = 1
    def initialize
        @balance = 0
        @in_use = false
    end
    def top_up(amount)
        if @balance + amount > MAX_BALANCE then raise "Balance exceeds maximum amount (#{MAX_BALANCE})" else @balance = @balance + amount end
    end
    def deduct(amount)
        @balance = @balance - amount
    end
    def touch_in(balance)
        if balance < MIN_BALANCE then raise "Balance is below minimum amount (#{MIN_BALANCE})" else @in_use = true end
    end
    def in_journey?
        @in_use == true ? true : false
    end
    def touch_out
        @in_use = false
    end
end