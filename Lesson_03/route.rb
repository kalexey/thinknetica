# class for describing route
class Route
  attr_reader :stations
  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def add_station(station, position = -2)
    @stations.insert(position, station)
  end

  def remove_station(station)
    return if [@stations.first, @stations.last].include?(station)

    @stations.delete(station) if @stations.include?(station)
  end

  def list_route_stations
    @stations.each do |s|
      puts "Station #{s.name}"
    end
  end

  def to_s
    s = "Route\r\n"
    @stations.each do |st|
      s += '    ' + st.name + "\r\n"
    end
    s
  end
end
