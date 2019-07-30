# frozen_string_literal: true

require_relative '../manufacturer'
require_relative '../validators/train_validator'

# class describing train
class Train
  attr_reader :type, :number, :current_speed,
              :current_route, :wagons, :current_station

  include Manufacturer
  include TrainValidator
  include InstanceCounter

  @@trains = {}

  def initialize(number)
    validate_train!(number)
    @number = number
    @type = nil
    @wagons = []
    @current_station = nil
    @current_route = nil
    @current_speed = 0
    @@trains[number] = self
    register_instance
  end

  def run(speed)
    validate_run!(speed)
    @current_speed = speed
  end

  def stop
    @current_speed = 0
  end

  def take_route(route)
    validate_route!(route)
    @current_route = route
    @current_station = route.stations.first
    @current_station.receive_train(self)
  end

  def add_wagon(wagon)
    validate_add_wagon!(wagon)
    @wagons << wagon
  end

  def remove_wagon(wagon)
    validate_remove_wagon!(wagon)
    @wagons.delete(wagon)
  end

  def next_station
    validate_next_station!
    index = @current_route.stations.index(@current_station)
    @current_route.stations[index + 1]
  end

  def prev_station
    validate_prev_station!
    index = @current_route.stations.index(@current_station)
    @current_route.stations[index - 1]
  end

  def move_next_station
    validate_next_station!
    @current_station.send_train(self)
    @current_station = next_station
    @current_station.receive_train(self)
  end

  def move_prev_station
    validate_prev_station!
    @current_station.send_train(self)
    @current_station = prev_station
    @current_station.receive_train(self)
  end

  def self.find(number)
    @@trains[number]
  end

  def show_info
    info = "Train: #{@number}, type: #{@type}, speed: #{@current_speed}. "
    info += if current_station.nil?
              'Route does not assigned'
            else
              "Currents station: #{@current_station.name}"
            end
    info
  end
end
