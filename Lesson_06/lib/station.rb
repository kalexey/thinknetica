# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validators/station_validator'
# class for describing station
class Station
  attr_reader :trains, :name
  @@stations = []

  include InstanceCounter
  include StationValidator

  def initialize(name)
    validate_station! name
    @name = name
    @trains = []
    register_instance
    @@stations << self
  end

  def receive_train(train)
    validate_receive_train!(train)
    @trains.push(train)
  end

  def send_train(train)
    validate_send_train!(train)
    @trains.delete(train)
  end

  def trains_list
    @trains
  end

  def trains_list_by_type(type)
    @trains.map { |t| t if t.type == type }
  end

  def self.all
    @@stations
  end
end
