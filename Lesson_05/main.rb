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
    system 'clear'
    loop do
      show_menu(MAIN_MENU)
      i = gets.chomp.to_i
      system 'clear'
      case i
      when 0 then station_menu
      when 1 then route_menu
      when 2 then train_menu
      when 3 then break
      else puts 'Wrong index'
      end
    end
  end

  private

  def station_menu
    loop do
      show_menu(STATION_MENU)
      i = gets.chomp.to_i
      system 'clear'

      case i
      when 0 then create_station
      when 1 then station_info
      when 2 then list_stations
      when 3 then break
      else puts 'Wrong index'
      end
    end
  end

  def create_station
    print 'Creating station. Enter station name: '
    name = gets.chomp
    if @stations.any? { |s| s.name == name }
      puts "Station with name #{name} already exists"
    else
      @stations << Station.new(name)
      puts "Station #{name} is created"
    end
  end

  def station_info
    list_stations
    station_index = select_station
    return if station_index.nil?
    
    puts 'station name:' + @stations[station_index].name
    if @stations[station_index].trains_list.empty?
      puts 'no trains at the station'
    else
      puts @stations[station_index].trains_list
    end
  end

  def route_menu
    loop do
      show_menu(ROUTE_MENU)
      i = gets.chomp.to_i
      system 'clear'
      case i
      when 0 then create_route
      when 1 then add_station_to_route
      when 2 then remove_station_from_route
      when 3 then list_routes
      when 4 then break
      else puts 'Wrong index'
      end
    end
  end

  def create_route
    list_stations
    puts 'Enter name of first and last station from list'

    name0, name1 = gets.chomp.split
    index0 = @stations.index { |s| s.name == name0 }
    if index0.nil?
      puts "Station #{name0} no exists"
      return
    end
    index1 = @stations.index { |s| s.name == name1 }
    if index1.nil?
      puts "Station #{name1} no exists"
      return
    end
    @routes << Route.new(@stations[index0], stations[index1])
  end

  def add_station_to_route
    list_routes
    route_index = select_route
    return if route_index.nil?

    list_stations
    station_index = select_station

    if station_index.nil?
      puts 'Incorrect station name'
      return
    end

    if @routes[route_index].stations.include?(@stations[station_index])
      puts 'Station already added'
      return
    end

    @routes[route_index].add_station(@stations[station_index])
  end

  def remove_station_from_route
    list_routes
    route_index = select_route
    return if route_index.nil?

    list_stations
    station_index = select_station

    return if station_index.nil?

    unless @routes[route_index].stations.include?(@stations[station_index])
      puts "this route doesn't contain a station #{@stations[station_index]}"
      return
    end

    @routes[route_index].remove_station(@stations[station_index])
  end

  def train_menu
    loop do
      show_menu(TRAIN_MENU)
      i = gets.chomp.to_i
      system 'clear'
      case i
      when 0 then create_pass_train
      when 1 then create_cargo_train
      when 2 then assign_route
      when 3 then add_wagon
      when 4 then remove_wagon
      when 5 then list_trains
      when 6 then forward
      when 7 then backward
      when 8 then break
      else puts 'Wrong index'
      end
    end
  end

  def create_pass_train
    print 'Create passenger train. Enter train number: '
    train_name = gets.chomp
    @trains << PassengerTrain.new(train_name)
  end

  def create_cargo_train
    print 'Create cargo train. Enter train number: '
    train_name = gets.chomp
    @trains << CargoTrain.new(train_name)
  end

  def delete_train; end

  def assign_route
    list_routes
    route_index = select_route
    return if route_index.nil?

    list_trains
    train_index = select_train
    return if train_index.nil?

    @trains[train_index].take_route(@routes[route_index])
  end

  def add_wagon
    puts 'Add wagon to train'
    list_trains
    train_index = select_train
    return if train_index.nil?

    train = @trains[train_index]

    train.add_wagon(PassengerWagon.new) if train.instance_of?(PassengerTrain)
    train.add_wagon(CargoWagon.new) if train.instance_of?(PassengerTrain)
  end

  def remove_wagon
    puts 'Remove wagon from train'
    train_index = select_train
    return if train_index.nil?

    train = @trains[train_index]

    train.remove_wagon(train.wagons.last)
  end

  def forward
    puts 'Move train forward'
    list_trains
    train_index = select_train
    return if train_index.nil?
    return if @trains[train_index].current_route.nil?

    @trains[train_index].move_next_station
  end

  def backward
    puts 'Move train backward'
    list_trains
    train_index = select_train
    return if train_index.nil?
    return if @trains[train_index].current_route.nil?

    @trains[train_index].move_prev_station
  end

  def show_menu(items)
    items.each_with_index { |s, i| puts "#{i}. #{s}" }
  end

  def select_route
    print 'Enter route index: '
    route_index = gets.chomp.to_i
    if route_index.negative? || route_index > @routes.length - 1
      puts 'Wrong route index'
      return nil
    end

    route_index
  end

  def select_station
    print 'Select station . Enter station name: '
    name = gets.chomp
    station_index = @stations.index { |s| s.name == name }
    if station_index.nil?
      puts "Station with name #{name} no exists"
      return nil
    end

    station_index
  end

  def list_stations
    puts 'list station'
    if @stations.empty?
      puts 'station list is empty'
    else
      @stations.each do |s|
        puts 'station name: ' + s.name.to_s
      end
    end
  end

  def list_routes
    if @routes.empty?
      puts 'route list is empty'
    else
      @routes.each_with_index do |_r, i|
        puts "route index : #{i}"
      end
    end
  end

  def list_trains
    if @trains.empty?
      puts 'train list is empty'
    else
      @trains.each(&:show_info)
    end
  end

  def select_train
    puts 'Select train. Enter train number: '
    train_number = gets.chomp

    train_index = @trains.index { |t| t.number == train_number }
    if train_index.nil?
      puts "train with number #{train_name} no exists"
      return nil
    end

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
