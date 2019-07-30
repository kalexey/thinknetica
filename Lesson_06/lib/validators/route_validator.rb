# frozen_string_literal: true

module RouteValidator
  def valid?
    validate_route!(@first_station, @last_station)
    true
  rescue StandardError
    false
  end

  private

  # validation before Route object creation
  def validate_route!(first_station, last_station)
    raise "#{first_station} is not a Station object" unless first_station.is_a? Station
    raise "#{last_station} is not a Station object" unless last_station.is_a? Station
  end

  # validation before adding intermediate station
  def validate_insert_station!(station)
    raise 'Station already inserted' if @stations.include?(station)
  end

  # validation before removing station
  def validate_remove_station!(station)
    raise "First station can't be removed from route" if station == @stations.first
    raise "Last station can't be removed from route" if station == @stations.last
    raise 'Route does not include this station' if @stations.include?(station)
  end
end
