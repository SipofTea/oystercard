# This class deals with the oystercard functionality
class Oystercard
  attr_reader :balance, :in_use, :entry_station

  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @balance = 0
  end

  def top_up(amount)
    @balance + amount > MAX_BALANCE ? (raise "Balance exceeds maximum amount (#{MAX_BALANCE})") : (@balance += amount)
  end

  def touch_in(entry_station)
    raise "Balance is below minimum amount (#{MIN_BALANCE})" if @balance < MIN_BALANCE

    @entry_station = entry_station
  end

  def in_journey?
    !!entry_station
  end

  def touch_out
    @entry_station = nil
    deduct(MIN_BALANCE)
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end