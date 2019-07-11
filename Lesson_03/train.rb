# class for train
class Train
  # attr_reader :number, :type, :nr_wagons, :current_route,
  #            :current_station, :prev_station, :next_station,
  #            :current_station_index

  attr_reader :current_speed, :type, :nr_wagons, :current_route

  def initialize(number, type, nr_wagons)
    @number = number
    @type = type
    @nr_wagons = nr_wagons
    @current_station = nil
    @current_speed = 0
  end

  def run(speed)
    @current_speed = speed
  end

  def stop
    @current_speed = 0
  end

  def add_wagon
    @nr_wagons += 1 if @current_speed.zero?
  end

  def remove_wagon
    @nr_wagons -= 1 if @nr_wagons > 0 && @current_speed.zero?
  end

  def next_station
    return @current_station if @current_route.stations.last == @current_station

    index = @current_route.stations.index(@current_station)
    @current_route.stations[index + 1]
  end

  attr_reader :current_station

  def prev_station
    return @current_station if @current_route.stations.first == @current_station

    index = @current_route.stations.index(@current_station)
    @current_route.stations[index - 1]
  end

  def route(r)
    @current_route = r
    @current_station = @current_route.stations.first
    @current_route.stations[0].receive_train(self)
  end

  def move_next_station
    if @current_station != @current_route.stations.last
      run(100)
      stop
      @current_station.send_train(self)
      @current_station = next_station
      @current_station.receive_train(self)
    end
  end

  def move_prev_station
    if @current_station != @current_route.stations.first
      run(100)
      stop
      @current_station.send_train(self)
      @current_station = prev_station
      @current_station.receive_train(self)
    end
  end

  def to_s
    "Train #{@number}, type #{@type}, number of wagons #{@nr_wagons}"
  end
end
