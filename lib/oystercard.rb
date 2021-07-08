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
    finish_journey unless @journey.nil?
    raise "Balance is below minimum amount (#{MIN_BALANCE})" if @balance < MIN_BALANCE

    start_new_journey(entry_station)
  end

  def start_new_journey(entry_station)
    @journey = Journey.new
    @journey.start_journey(entry_station)
  end

  def finish_journey
    deduct(journey.fare)
    @journey_history << @journey.current_journey
    @journey = nil
  end

  def in_journey?
    !!@journey
  end

  def touch_out(exit_station)
    @journey = Journey.new if @journey.nil?
    @journey.end_journey(exit_station)
    finish_journey
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
