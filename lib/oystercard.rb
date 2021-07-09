require_relative 'journey'
require_relative 'journey_log'

# This class deals with the oystercard functionality
class Oystercard
  attr_reader :balance, :journey_log

  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @balance = 0
    @journey_log = JourneyLog.new(Journey)
  end

  def top_up(amount)
    @balance + amount > MAX_BALANCE ? (raise "Balance exceeds maximum amount (#{MAX_BALANCE})") : (@balance += amount)
  end

  def touch_in(entry_station)
    deduct(@journey_log.journey.fare) unless @journey_log.journey.nil?
    raise "Balance is below minimum amount (#{MIN_BALANCE})" if @balance < MIN_BALANCE

    @journey_log.start(entry_station)
  end

  def in_journey?
    !!@journey_log.journey
  end

  def touch_out(exit_station)
    if in_journey?
      @journey_log.finish(exit_station)
      deduct(@journey_log.journeys.last.fare)
    else
      deduct(Journey::PENALTY_FARE)
    end
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
