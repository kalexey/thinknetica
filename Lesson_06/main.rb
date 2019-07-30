# frozen_string_literal: true

require_relative 'lib/station'
require_relative 'lib/route'

require_relative 'lib/train/passenger_train'
require_relative 'lib/train/cargo_train'
require_relative 'lib/train/train'

require_relative 'lib/wagon/passenger_wagon'
require_relative 'lib/wagon/cargo_wagon'
require_relative 'lib/wagon/wagon'

# class describing control terminal
class RailwayMenu
  attr_reader :stations, :routes, :trains
  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  def main_menu
    loop do
      puts 'Main menu'
      show_menu(MAIN_MENU)
      i = gets.chomp.to_i
      system 'clear'
      case i
      when 1 then station_menu
      when 2 then route_menu
      when 3 then train_menu
      when 4 then exit
      else raise "Wrong selection. Select from 1 to #{MAIN_MENU.length - 1}"
      end
    end
  rescue RuntimeError => e
    puts e.message.to_s
    retry
  end

  private

  def station_menu
    loop do
      puts 'Station menu'
      show_menu(STATION_MENU)
      i = gets.chomp.to_i
      system 'clear'
      case i
      when 1 then create_station
      when 2 then station_info
      when 3 then list_stations
      when 4 then return
      else raise "Wrong selection. Select from 1 to #{STATION_MENU.length - 1}"
      end
    end
  rescue RuntimeError => e
    puts e.message.to_s
    retry
  end

  def create_station
    print 'Creating station. Enter station name: '
    name = gets.chomp
    raise "Station with name #{name} already exists" if station_exists?(name)

    @stations << Station.new(name)
    puts "Station #{name} is created"
  end

  def station_info
    raise 'Station list is empty' if @stations.empty?

    list_stations
    station_index = select_station

    puts 'station name:' + @stations[station_index].name
    if @stations[station_index].trains_list.empty?
      puts 'no trains at the station'
    else
      puts @stations[station_index].trains_list
    end
  end

  def route_menu
    loop do
      puts 'Route menu'
      show_menu(ROUTE_MENU)
      i = gets.chomp.to_i
      system 'clear'
      case i
      when 1 then create_route
      when 2 then add_station_to_route
      when 3 then remove_station_from_route
      when 4 then list_routes
      when 5 then return
      else raise "Wrong selection. Select from 1 to #{ROUTE_MENU.length - 1}"
      end
    end
  rescue RuntimeError => e
    puts e.message.to_s
    retry
  end

  def create_route
    raise 'Station list is empty. Create 2 station at least' if @stations.empty?

    list_stations
    puts 'Enter name of first and last station from list'

    name0, name1 = gets.chomp.split
    index0 = find_station_index(name0)
    index1 = find_station_index(name1)
    @routes << Route.new(@stations[index0], stations[index1])
    puts "Route #{@routes.last.route_name} is created"
  end

  def add_station_to_route
    raise 'Route list is empty' if @routes.empty?

    list_routes
    route_index = select_route

    list_stations
    station_index = select_station

    @routes[route_index].add_station(@stations[station_index])
    puts 'Station added to route'
  end

  def remove_station_from_route
    raise 'Route list is empty' if @routes.empty?

    list_routes
    route_index = select_route

    list_stations
    station_index = select_station

    @routes[route_index].remove_station(@stations[station_index])
    puts 'Station removed from route'
  end

  def train_menu
    loop do
      show_menu(TRAIN_MENU)
      i = gets.chomp.to_i
      system 'clear'
      case i
      when 1 then create_pass_train
      when 2 then create_cargo_train
      when 3 then assign_route
      when 4 then add_wagon
      when 5 then remove_wagon
      when 6 then list_trains
      when 7 then forward
      when 8 then backward
      when 9 then return
      else raise "Wrong selection. Select from 0 to #{TRAIN_MENU.length - 1}"
      end
    end
  rescue RuntimeError => e
    puts e.message.to_s
    retry
  end

  def create_pass_train
    print 'Create passenger train. Enter train number: '
    train_number = gets.chomp
    raise "Train #{train_number} already created" if train_exists?(train_number)

    @trains << PassengerTrain.new(train_number)
    puts "Passenger train #{train_number} created"
  end

  def create_cargo_train
    print 'Create cargo train. Enter train number: '
    train_number = gets.chomp
    raise "Train #{train_number} already created" if train_exists?(train_number)

    @trains << CargoTrain.new(train_number)
    puts "Cargo train #{train_number} created"
  end

  def delete_train; end

  def assign_route
    raise 'Route list is empty' if @routes.empty?

    list_routes
    route_index = select_route

    list_trains
    train_index = select_train

    @trains[train_index].take_route(@routes[route_index])
    puts 'Route assigned'
  end

  def add_wagon
    puts 'Add wagon to train'
    list_trains
    train_index = select_train
    train = @trains[train_index]
    train.add_wagon(PassengerWagon.new) if train.instance_of?(PassengerTrain)
    train.add_wagon(CargoWagon.new) if train.instance_of?(CargoTrain)
    puts 'Wagon added'
  end

  def remove_wagon
    puts 'Remove wagon from train'
    list_trains
    train_index = select_train
    train = @trains[train_index]
    train.remove_wagon(train.wagons.last)
    puts 'Wagon removed'
  end

  def forward
    puts 'Move train forward'
    list_trains
    train_index = select_train
    @trains[train_index].move_next_station
    puts 'Train was moved to next station'
  end

  def backward
    puts 'Move train backward'
    list_trains
    train_index = select_train
    @trains[train_index].move_prev_station
    puts 'Train was moved to previous station'
  end

  def show_menu(items)
    items.each_with_index { |s, i| puts "#{i + 1}. #{s}" }
  end

  def select_route
    print 'Enter route index: '
    route_index = gets.chomp.to_i
    return route_index if (0...@routes.length).to_a.include?(route_index)

    raise "Wrong route selection. Select from 0 to #{@routes.length - 1}"
  end

  def find_station_index(name)
    station_index = @stations.index { |s| s.name == name }
    raise "Station #{name} not found" if station_index.nil?

    station_index
  end

  def station_exists?(name)
    station_index = @stations.index { |s| s.name == name }
    return false if station_index.nil?

    true
  end

  def select_station
    print 'Select station . Enter station name: '
    name = gets.chomp
    return find_station_index(name) if station_exists?(name)

    raise "Station with name #{name} doesn't exists"
  end

  def list_stations
    raise 'Station list is empty' if @stations.empty?

    puts 'list station'
    @stations.each { |s| puts 'station name: ' + s.name.to_s }
  end

  def list_routes
    raise 'Route list is empty' if @routes.empty?

    @routes.each_with_index { |r, i| puts "#{i}. #{r.route_name}" }
  end

  def list_trains
    raise 'Train list is empty' if @trains.empty?

    @trains.each { |t| puts t.show_info }
  end

  def train_exists?(train_number)
    train_index = @trains.index { |t| t.number == train_number }
    return false if train_index.nil?

    true
  end

  def find_train_index(train_number)
    train_index = @trains.index { |t| t.number == train_number }
    train_index
  end

  def select_train
    puts 'Select train. Enter train number: '
    train_number = gets.chomp

    raise 'Train list is empty' if @trains.empty?

    train_index = find_train_index(train_number)
    raise "Train with number #{train_number} does not exists" unless train_exists?(train_number)

    train_index
  end

  MAIN_MENU = ['Station menu',
               'Route menu',
               'Train menu',
               'Exit'].freeze

  STATION_MENU = ['create station',
                  'station info',
                  'stations list',
                  'return'].freeze

  ROUTE_MENU = ['create route',
                'add station to route',
                'remove station from route',
                'list routes',
                'return'].freeze

  TRAIN_MENU = ['create passenger train',
                'create cargo train',
                'assign route',
                'add wagon',
                'remove wagon',
                'list trains',
                'forward',
                'backward',
                'return'].freeze
end

rm = RailwayMenu.new
rm.main_menu
