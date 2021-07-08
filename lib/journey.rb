# This class deals with the current journey
class Journey
  attr_reader :entry_station, :exit_station, :current_journey

  def start_journey(entry_station)
    @entry_station = entry_station
    @current_journey = { entry_station: @entry_station }
  end

  def end_journey(exit_station)
    @exit_station = exit_station
    @current_journey[:exit_station] = @exit_station
  end
end
