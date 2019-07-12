# class for train
class Train
  attr_reader :current_speed, :type, :wagons_count, :current_route,
              :current_station

  def initialize(number, type, wagons_count)
    @number = number
    @type = type
    @wagons_count = wagons_count
    @current_station = nil
    @current_speed = 0
  end

  def run(speed)
    return if speed.negative?

    @current_speed = speed
  end

  def stop
    @current_speed = 0
  end

  def add_wagon
    @wagons_count += 1 if @current_speed.zero?
  end

  def remove_wagon
    @wagons_count -= 1 if @wagons_count > 0 && @current_speed.zero?
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

  def take_route(route)
    @current_route = route
    @current_station = @current_route.stations.first
    @current_route.stations[0].receive_train(self)
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
end
