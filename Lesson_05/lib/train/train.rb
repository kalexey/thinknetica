# frozen_string_literal: true

require_relative '../manufacturer'

# class describing train
class Train
  attr_reader :type, :number, :current_speed,
              :current_route, :wagons, :current_station

  include Manufacturer
  include InstanceCounter

  @@trains = {}

  def initialize(number = 0)
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
    return if speed.negative?

    @current_speed = speed
  end

  def stop
    @current_speed = 0
  end

  def take_route(route)
    @current_route = route
    @current_station = route.stations.first
    @current_station.receive_train(self)
  end

  def add_wagon(wagon)
    return unless @current_speed.zero?
    return unless wagon.type == @type

    @wagons << wagon unless @wagons.include?(wagon)
  end

  def remove_wagon(wagon)
    return unless @current_speed.zero?

    @wagons.delete(wagon) if @wagons.include?(wagon)
  end

  def next_station
    return @current_station if @current_route.stations.last == @current_station

    index = @current_route.stations.index(@current_station)
    @current_route.stations[index + 1]
  end

  def prev_station
    return @current_station if @current_route.stations.first == @current_station

    index = @current_route.stations.index(@current_station)
    @current_route.stations[index - 1]
  end

  def move_next_station
    return if @current_station == @current_route.stations.last

    @current_station.send_train(self)
    @current_station = next_station
    @current_station.receive_train(self)
  end

  def move_prev_station
    return if @current_station == @current_route.stations.first

    @current_station.send_train(self)
    @current_station = prev_station
    @current_station.receive_train(self)
  end

  def show_info
    puts "Train: #{@number}, type:  #{@type}, speed : #{@current_speed}"
    puts 'Currents station:' + @current_station.name unless current_station.nil?
    # @wagons.each(&:show_info)
  end

  def self.find(number)
    @@trains[number]
  end
end
