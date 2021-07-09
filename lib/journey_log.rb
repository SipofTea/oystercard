require_relative 'journey'

# This class starts, stops, and stores journeys
class JourneyLog
  attr_reader :journey_class, :journey

  def initialize(journey_class)
    @journey_class = journey_class
    @journey_history = []
  end

  def start(entry_station)
    current_journey
    @journey.start_journey(entry_station)
  end

  def finish(exit_station)
    current_journey
    @journey.end_journey(exit_station)
    @journey_history << @journey
    @journey = nil
  end

  def journeys
    @journey_history.dup
  end

  private

  def current_journey
    if @journey.nil?
      @journey = journey_class.new
    else
      @journey.current_journey
    end
  end
end
