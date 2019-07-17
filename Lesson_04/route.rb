# frozen_string_literal: true

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

  def route_name
    stations.first.name + ' - ' + stations.last.name
  end

  def list_route_stations
    stations.map(&:name)
  end
end
