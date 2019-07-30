# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validators/route_validator'
# class for describing route
class Route
  include InstanceCounter
  include RouteValidator
  attr_reader :stations
  def initialize(first_station, last_station)
    validate_route! first_station, last_station
    @stations = [first_station, last_station]
    register_instance
  end

  def add_station(station, position = -2)
    validate_insert_station!(station)
    @stations.insert(position, station)
  end

  def remove_station(station)
    validate_remove_station!(station)
    @stations.delete(station)
  end

  def route_name
    stations.first.name + ' - ' + stations.last.name
  end

  def list_route_stations
    stations.map(&:name)
  end
end
