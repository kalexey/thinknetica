# class for describing station
class Station
  attr_reader :trains, :name
  def initialize(name)
    @name = name
    @trains = []
  end

  def receive_train(train)
    @trains.push(train)
  end

  def send_train(train)
    @trains.delete(train)
  end

  def trains_list
    @trains
  end

  def trains_list_by_type(type)
    list = []
    @trains.each do |t|
      list << t if t.type == type
    end
    list
  end

  def to_s
    s = "Station #{@name}\r\n"
    trains.each do |t|
      s += '    ' + t.to_s + "\r\n"
    end
    s
  end
end
