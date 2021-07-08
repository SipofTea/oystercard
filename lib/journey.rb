# This class deals with the current journey
class Journey
  attr_reader :entry_station, :exit_station, :current_journey

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @current_journey = {}
  end

  def start_journey(entry_station)
    @entry_station = entry_station
    @current_journey[:entry_station] = @entry_station
  end

  def end_journey(exit_station)
    @exit_station = exit_station
    @current_journey[:exit_station] = @exit_station
  end

  def fare
    complete? == true ? MINIMUM_FARE : PENALTY_FARE
  end

  def complete?
    current_journey[:entry_station].nil? || current_journey[:exit_station].nil? ? false : true
  end
end
