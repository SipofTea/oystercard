class Oystercard
attr_reader :balance, :in_use, :entry_station
MAX_BALANCE = 90
MIN_BALANCE = 1
    def initialize
        @balance = 0
    end
    def top_up(amount)
        if @balance + amount > MAX_BALANCE then raise "Balance exceeds maximum amount (#{MAX_BALANCE})" else @balance = @balance + amount end
    end
    
    def touch_in(entry_station)
        if @balance < MIN_BALANCE then raise "Balance is below minimum amount (#{MIN_BALANCE})" end
        @entry_station = entry_station
        end
    def in_journey?
        !!entry_station
        # if @entry_station != nil then true else false end
    end
    def touch_out
        @entry_station = nil
        deduct(MIN_BALANCE)
    end
    
private 
    def deduct(amount)
        @balance = @balance - amount
    end
end
