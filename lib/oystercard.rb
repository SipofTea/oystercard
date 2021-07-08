require 'journey'

# This class deals with the oystercard functionality
class Oystercard
  attr_reader :balance, :journey_history, :journey

  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(amount)
    @balance + amount > MAX_BALANCE ? (raise "Balance exceeds maximum amount (#{MAX_BALANCE})") : (@balance += amount)
  end

  def touch_in(entry_station)
    raise "Balance is below minimum amount (#{MIN_BALANCE})" if @balance < MIN_BALANCE

    @journey = Journey.new
    @journey.start_journey(entry_station)
  end

  def in_journey?
    !!@journey.entry_station
  end

  def touch_out(exit_station)
    @journey.end_journey(exit_station)
    @journey_history << journey.current_journey
    deduct(MIN_BALANCE)
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
