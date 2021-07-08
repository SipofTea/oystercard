require 'journey'

# This class deals with the oystercard functionality
class Oystercard
  attr_reader :balance, :in_use, :entry_station, :exit_station, :journey_history, :current_journey

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

    @entry_station = entry_station
    @current_journey = { entry_station: @entry_station }
  end

  def in_journey?
    !!entry_station
  end

  def touch_out(exit_station)
    @entry_station = nil
    @exit_station = exit_station
    @current_journey[:exit_station] = @exit_station
    @journey_history << @current_journey
    deduct(MIN_BALANCE)
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
