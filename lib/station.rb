# This class deals with the station instance
class Station
  attr_reader :station_name, :station_zone

  def name(station_name)
    @station_name = station_name
  end

  def zone(station_zone)
    @station_zone = station_zone
  end
end
